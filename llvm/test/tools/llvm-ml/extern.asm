; RUN: llvm-ml -m32 -filetype=s %s /Fo - | FileCheck %s --check-prefixes=CHECK,CHECK-32
; RUN: llvm-ml -m64 -filetype=s %s /Fo - | FileCheck %s --check-prefixes=CHECK,CHECK-64

extern foo : dword, bar : word, baz : proc, qux : near, quz : far
; CHECK: .extern foo
; CHECK: .extern bar
; CHECK: .extern baz
; CHECK: .extern qux
; CHECK: .extern quz

.code
mov ebx, foo
; CHECK-32: mov ebx, dword ptr [foo]
; CHECK-64: mov ebx, dword ptr [rip + foo]

mov bx, bar
; CHECK-32: mov bx, word ptr [bar]
; CHECK-64: mov bx, word ptr [rip + bar]

call baz
; CHECK: call baz

call qux
; CHECK: call qux

call quz
; CHECK: call quz

END
