import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:portfolio_flutter/modules/core/data/network/request/request_profile.dart';
import 'package:portfolio_flutter/modules/core/data/network/response/response_profile.dart';
import 'package:portfolio_flutter/modules/core/data/profile_repository.dart';
import 'package:portfolio_flutter/modules/core/data/route_repository.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_event.dart';
import 'package:portfolio_flutter/modules/uiprofile/bloc/uiprofile_bloc_state.dart';

import 'uiprofile_bloc_test.mocks.dart';

class ProfileRespositoryMock extends Mock implements ProfileRepository {}

class RouteRepositoryMock extends Mock implements RouteRepository {}

@GenerateMocks([ProfileRespositoryMock, RouteRepositoryMock])
void main() {
  late UiProfileBloc uiProfileBloc;
  late MockProfileRespositoryMock profileRespositoryMock;
  late MockRouteRepositoryMock routeRepositoryMock;

  setUp(() {
    profileRespositoryMock = MockProfileRespositoryMock();
    routeRepositoryMock = MockRouteRepositoryMock();

    uiProfileBloc = UiProfileBloc(
      profileRepository: profileRespositoryMock,
      routeRepository: routeRepositoryMock,
    );
  });

  blocTest<UiProfileBloc, UiProfileBlocState>(
    'when emmit state to update profile and return success',
    build: () {
      when(
        profileRespositoryMock.sendProfile(any),
      ).thenAnswer((_) async {});

      when(
        routeRepositoryMock.save(any),
      ).thenAnswer((_) async {});

      return uiProfileBloc;
    },
    act: (bloc) => bloc.add(SendProfile(profile: RequestProfile())),
    expect: () => [
      const UiProfileBlocStateLoading(),
      const UiProfileBlocStateUpdateSuccess(),
    ],
  );

  blocTest<UiProfileBloc, UiProfileBlocState>(
    'when emmit state to update profile and return error',
    build: () {
      when(
        profileRespositoryMock.sendProfile(any),
      ).thenThrow(Exception("error"));

      return uiProfileBloc;
    },
    act: (bloc) => bloc.add(SendProfile(profile: RequestProfile())),
    expect: () => [
      const UiProfileBlocStateLoading(),
      const UiProfileBlocStateError(),
    ],
  );

  blocTest<UiProfileBloc, UiProfileBlocState>(
    'when emmit state to get profile and return error',
    build: () {
      when(profileRespositoryMock.getProfile()).thenThrow(Exception(fail));
      return uiProfileBloc;
    },
    act: (bloc) => bloc.add(GetProfile()),
    expect: () => [
      const UiProfileBlocStateLoading(),
      const UiProfileBlocStateError(),
    ],
  );

  blocTest<UiProfileBloc, UiProfileBlocState>(
    'when emmit state to get profile',
    build: () {
      when(
        profileRespositoryMock.getProfile(),
      ).thenAnswer(
        (_) async => ResponseProfile(
          name: 'profile name',
        ),
      );

      return uiProfileBloc;
    },
    act: (bloc) => bloc.add(GetProfile()),
    expect: () => [
      const UiProfileBlocStateLoading(),
      UiProfileBlocStateProfileSaved(responseProfile: ResponseProfile()),
    ],
  );

  tearDown(() {
    uiProfileBloc.close();
  });
}
