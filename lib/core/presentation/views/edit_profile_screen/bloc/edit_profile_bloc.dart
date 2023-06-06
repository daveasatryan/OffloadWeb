import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_extensions_methods/dart_extension_methods.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:therapist_journey/core/data/models/calendar/calendar_editing_model.dart';
import 'package:therapist_journey/core/data/models/calendar/date_book_item_model.dart';
import 'package:therapist_journey/core/data/models/user/user_model.dart';
import 'package:therapist_journey/core/data/models/week_day_model/week_day_model.dart';
import 'package:therapist_journey/core/data/usecases/user/canedar_date_usecase.dart';
import 'package:therapist_journey/core/data/usecases/user/edit_profile_usecase.dart';
import 'package:therapist_journey/core/data/usecases/user/upload_image_usecase.dart';
import 'package:therapist_journey/core/data/utilities/date_utilities.dart';
import 'package:therapist_journey/core/data/utilities/storage/preferences_manager.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_event.dart';
import 'package:therapist_journey/core/presentation/views/edit_profile_screen/bloc/edit_profile_state.dart';

@injectable
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  File? image;

  List<WeekDayModel> weekDayList = [];
  List<String> calendarUuidsList = [];

  EditProfileBloc(this._editProfileUsecase, this._uploadImageUsecase, this._calendarDateUsecase)
      : super(const EditProfileState.initial()) {
    on<GetUserEditInitial>((event, emit) async {
      const EditProfileState.loading();
      for (var i = 0; i < DateUtilities.week.length; i++) {
        weekDayList.add(
          WeekDayModel(
            day: DateUtilities.week[i],
            weekBookList: event.userModel.graphic[i].weekBookList,
          ),
        );
      }
      emit(
        EditProfileState.userData(
          user: PreferencesManager.user,
          weekDayList: List.from(weekDayList),
        ),
      );
    });
    on<EditUserData>(
      (event, emit) async {
        bool isCallEdit = false;
        final requestModel = event.weekDayList
            .map((e) => e.weekBookList)
            .expand((element) => element)
            .map((e) => e.toRequestModel())
            .toList();
        for (var model in requestModel) {
          if (model.isRepeat == true) {
            requestModel.add(
              model.copyWith(
                uuid: null,
                isRepeat: false,
                startDate: (model.startDate ?? 0) + (const Duration(days: 7).inSeconds),
                endDate: (model.endDate ?? 0) + (const Duration(days: 7).inSeconds),
                isBooked: false,
              ),
            );
          }
        }
        (await _calendarDateUsecase(CalendarEditingModel(
          calendars: requestModel,
          deletedCalendarUuids: calendarUuidsList.where((e) => e.isNotNullOrEmpty()).toList(),
        )))
            .whenOrNull(
          success: (data) async {
            calendarUuidsList.clear();
            isCallEdit = true;
            emit(
              EditProfileState.successCalendar(user: data?.result),
            );
          },
          error: (msg, errorCode) => emit(
            EditProfileState.error(msg: msg, errorCode: errorCode),
          ),
        );
        isCallEdit
            ? (await _editProfileUsecase(UserModel(
                uuid: event.uuid,
                firstName: event.name,
                sessionPrice: event.sessionPrice,
                bio: event.bio,
                certifications: event.certifications,
              )))
                .whenOrNull(
                success: (data) {
                  emit(
                    EditProfileState.success(user: data?.result),
                  );
                },
                error: (msg, errorCode) => emit(
                  EditProfileState.error(msg: msg, errorCode: errorCode),
                ),
              )
            : null;
      },
    );
    on<UploadImage>(
      (event, emit) async {
        try {
          final images = await ImagePicker().pickImage(source: ImageSource.gallery);
          if (images == null) {
            return;
          }
          final imageWeb = await images.readAsBytes();
          image = File(images.path);

          (await _uploadImageUsecase(
            bytes: imageWeb,
            fileName: image.toString(),
          ))
              .whenOrNull(
            success: (data) {
              emit(EditProfileState.successUploadImage(user: data?.result));
            },
            error: (msg, errorCode) => emit(EditProfileState.error(msg: msg, errorCode: errorCode)),
          );
        } on PlatformException catch (e) {
          emit(EditProfileState.error(msg: e.toString(), errorCode: ''));
        }
      },
    );
  }

  final EditProfileUsecase _editProfileUsecase;
  final UploadImageUsecase _uploadImageUsecase;
  final CalendarDateUsecase _calendarDateUsecase;
}
