<p align="center">
  <img src="https://github.com/ChoMyeongHwan/CodeClimX/assets/114536581/7e874413-9cbc-4bbc-86a2-8a48ea9246d7" alt="CodeClimX_로고">
</p>
<h1 align="center">CodeClimX</h1>
<h3 align="center">명강의 학습을 위한 AI 기반의 학습 어플리케이션</h3>




<p align="center">⁉️ 퀴즈 생성 레포지토리 : 
https://github.com/ChoMyeongHwan/CodeClimX_QuizGenerator</p>

<br/>

# 📝 소개
AI를 활용하여 개발 관련 해외 대학 강의에 한글 자막을 추가한 동영상을 제공하는 모바일 어플리케이션입니다. 강의 내용 기반 RAG 챗봇, 강의 내용 기반 생성형 AI 퀴즈, 그리고 커뮤니티를 제공하여 영어권 나라에서 주도하는 신기술 정보를 빠르게 전달하고자 합니다. YOUTUBE와 같은 대형 플랫폼에서 제공되는 명강의들을 한글로 번역하여 더 많은 개발자들이 접근할 수 있도록 합니다.

<br/>

# 🌁 사용 기술
Flutter와 Python을 기반으로 하는 프론트엔드와 백엔드 통합 구조입니다. 백엔드에서는 FastAPI, PyTorch, OpenAI를 활용한 AI 모델 배포를 지원합니다. 음성 인식(STT) 및 자연어 처리 기능에는 Splade와 SentenceTransformers 임베딩 모델을 사용합니다.

<br/>

# 🎞 Demo
[CodeClimX_데모_보기](https://github.com/ChoMyeongHwan/CodeClimX/assets/114536581/4df41b6b-f821-4c89-a8c3-e6a14656f379)

<br/>

# ⭐ 주요 기능
## 강의 내용 번역
한글 번역이 적용된 강의 영상 제공 및 영상 내용 기반 검색 기능을 제공합니다.


## RAG 챗봇
강의 내용 중 모르는 부분을 RAG 기반 챗봇에게 질문할 수 있습니다.

## 퀴즈
주관식, 객관식 퀴즈 및 피드백을 제공하여 학습 효과를 극대화합니다.

## 커뮤니티
강의 내용 외의 질문에 AI가 자동 답변하며, 사용자 간의 커뮤니티 형성을 지원합니다.

<br/>

# 🔨 프로젝트 구조
프로젝트의 전체 구조를 보여주는 아키텍처입니다.
![Architecture](https://github.com/ChoMyeongHwan/CodeClimX/assets/114536581/15c740e0-8ae6-46d0-ac63-7740241424ad)


<br/>

# 🔧 Stack

**Frontend(IOS, Android)**
- **Language**: Dart
- **Library & Framework**: Flutter

**Backend**
- **Language**: Python
- **Library & Framework**: FastAPI, PyTorch, SBERT.net & Sentence Transformers, Huggingface, Langchain, Pinecone
- **Database**: Firebase(Storage)
