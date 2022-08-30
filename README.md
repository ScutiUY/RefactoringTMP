# TMP - Travel Manage Planner

[![CI Status](https://img.shields.io/travis/ScutiUY/UYRadioButton.svg?style=flat)](https://travis-ci.org/ScutiUY/UYRadioButton) [![Version](https://img.shields.io/cocoapods/v/UYRadioButton.svg?style=flat)](https://cocoapods.org/pods/UYRadioButton) [![License](https://img.shields.io/cocoapods/l/UYRadioButton.svg?style=flat)](https://cocoapods.org/pods/UYRadioButton) [![Platform](https://img.shields.io/cocoapods/p/UYRadioButton.svg?style=flat)](https://cocoapods.org/pods/UYRadioButton) <img src="https://img.shields.io/badge/version-1.0.1-blue.svg?{ style(optional)"> <img src="https://img.shields.io/badge/Swift-F05138?style=flat&logo=Swift&logoColor=white"/></a> 
<div align="center">
<img src = "https://user-images.githubusercontent.com/59588256/154836068-bd7efce0-bed9-4d7d-a76e-0b2e64ca0e27.png" width="40%" height="40%">
</div>


## 개요
본 프로젝트는 기존의 프로젝트를 리팩토링하며 얻은 깨달음을 기록하고 보다 더 나은 코드를 지향하는 목적으로 시작 되었습니다.

## 기존 프로젝트 소개
https://github.com/TravelMockPlanner/TravelManagerPlanner
https://github.com/TravelMockPlanner/TravelManagerPlanner/wiki

- 로그인/회원가입
- 테마 설정 및 테마 별 숙소, 식당, 놀거리 장소를 선택 할수 있는 장바구니 기능
- 장바구니에 담긴 여행 일정 보여주기 및 예약한 여정 보여주기
- 여행지 정보에 대한 커뮤니티 

## 리팩토링 목록
- 네트워크
    - 네트워크 레이어 나누기 (네트워크 레이어 꼭 필요한가?)
- 로그인/회원가입
    - UserKey 다루기 (싱글톤인가 UserDefault인가? - 싱글톤에 대한 고찰)
    - 암호화 (왜 암호화를 해야 하는가?)
- 여행 리스트
    - 최적화
        - Delegate retain cycle 방지
        - 접근 제한 (Dispatch)

## 리팩토링 스토리
https://debonair-record-6e9.notion.site/1cb1c441700145e0b3e51c42cf27e9d9

