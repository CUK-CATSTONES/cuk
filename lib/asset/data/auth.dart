enum Auth {
  /// [signIn]은 이메일 인증이 되지 않고, 로그인이 완료된 상태를 의미합니다.
  signIn,

  /// [signOut]은 로그아웃된 상태를 의미합니다.
  signOut,

  /// [emailVerified]은 이메일 인증이 완료되고, 로그인이 완료된 상태를 의미합니다.
  emailVerified,

  /// [isAnonymous]은 익명 로그인 상태를 의미합니다.
  isAnonymous,
}
