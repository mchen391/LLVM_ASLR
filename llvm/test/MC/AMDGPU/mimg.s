// RUN: llvm-mc -arch=amdgcn -show-encoding %s | FileCheck %s --check-prefix=SICI
// RUN: llvm-mc -arch=amdgcn -mcpu=tahiti -show-encoding %s | FileCheck %s --check-prefix=SICI
// RUN: llvm-mc -arch=amdgcn -mcpu=fiji -show-encoding %s | FileCheck %s --check-prefix=VI

//===----------------------------------------------------------------------===//
// Image Load/Store
//===----------------------------------------------------------------------===//

image_load    v[4:6], v[237:240], s[28:35] dmask:0x7 unorm
// SICI: image_load v[4:6], v[237:240], s[28:35] dmask:0x7 unorm ; encoding: [0x00,0x17,0x00,0xf0,0xed,0x04,0x07,0x00]
// VI:   image_load v[4:6], v[237:240], s[28:35] dmask:0x7 unorm ; encoding: [0x00,0x17,0x00,0xf0,0xed,0x04,0x07,0x00]

image_store   v[193:195], v[237:240], s[28:35] dmask:0x7 unorm
// SICI: image_store v[193:195], v[237:240], s[28:35] dmask:0x7 unorm ; encoding: [0x00,0x17,0x20,0xf0,0xed,0xc1,0x07,0x00]
// VI:   image_store v[193:195], v[237:240], s[28:35] dmask:0x7 unorm ; encoding: [0x00,0x17,0x20,0xf0,0xed,0xc1,0x07,0x00]

//===----------------------------------------------------------------------===//
// Image Sample
//===----------------------------------------------------------------------===//

image_sample  v[193:195], v[237:240], s[28:35], s[4:7] dmask:0x7 unorm
// SICI: image_sample v[193:195], v[237:240], s[28:35], s[4:7] dmask:0x7 unorm ; encoding: [0x00,0x17,0x80,0xf0,0xed,0xc1,0x27,0x00]
// VI:   image_sample v[193:195], v[237:240], s[28:35], s[4:7] dmask:0x7 unorm ; encoding: [0x00,0x17,0x80,0xf0,0xed,0xc1,0x27,0x00]

//===----------------------------------------------------------------------===//
// Image Atomics
//===----------------------------------------------------------------------===//

image_atomic_add v4, v[192:195], s[28:35] dmask:0x1 unorm glc
// SICI: image_atomic_add v4, v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x44,0xf0,0xc0,0x04,0x07,0x00]
// VI:   image_atomic_add v4, v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x48,0xf0,0xc0,0x04,0x07,0x00]

image_atomic_add v5, v1, s[8:15]
// SICI: image_atomic_add v5, v1, s[8:15] ; encoding: [0x00,0x00,0x44,0xf0,0x01,0x05,0x02,0x00]
// VI:   image_atomic_add v5, v1, s[8:15] ; encoding: [0x00,0x00,0x48,0xf0,0x01,0x05,0x02,0x00]

image_atomic_add v252, v2, s[8:15] unorm
// SICI: image_atomic_add v252, v2, s[8:15] unorm ; encoding: [0x00,0x10,0x44,0xf0,0x02,0xfc,0x02,0x00]
// VI:   image_atomic_add v252, v2, s[8:15] unorm ; encoding: [0x00,0x10,0x48,0xf0,0x02,0xfc,0x02,0x00]

image_atomic_add v6, v255, s[8:15] dmask:0x1
// SICI: image_atomic_add v6, v255, s[8:15] dmask:0x1 ; encoding: [0x00,0x01,0x44,0xf0,0xff,0x06,0x02,0x00]
// VI:   image_atomic_add v6, v255, s[8:15] dmask:0x1 ; encoding: [0x00,0x01,0x48,0xf0,0xff,0x06,0x02,0x00]

image_atomic_add v7, v3, s[0:7] glc
// SICI: image_atomic_add v7, v3, s[0:7] glc ; encoding: [0x00,0x20,0x44,0xf0,0x03,0x07,0x00,0x00]
// VI:   image_atomic_add v7, v3, s[0:7] glc ; encoding: [0x00,0x20,0x48,0xf0,0x03,0x07,0x00,0x00]

image_atomic_add v8, v4, s[8:15] slc
// SICI: image_atomic_add v8, v4, s[8:15] slc ; encoding: [0x00,0x00,0x44,0xf2,0x04,0x08,0x02,0x00]
// VI:   image_atomic_add v8, v4, s[8:15] slc ; encoding: [0x00,0x00,0x48,0xf2,0x04,0x08,0x02,0x00]

image_atomic_add v9, v5, s[8:15] dmask:0x1 unorm glc slc lwe da
// SICI: image_atomic_add v9, v5, s[8:15] dmask:0x1 unorm glc slc lwe da ; encoding: [0x00,0x71,0x46,0xf2,0x05,0x09,0x02,0x00]
// VI:   image_atomic_add v9, v5, s[8:15] dmask:0x1 unorm glc slc lwe da ; encoding: [0x00,0x71,0x4a,0xf2,0x05,0x09,0x02,0x00]

image_atomic_add v10, v6, s[8:15] dmask:0x1 lwe
// SICI: image_atomic_add v10, v6, s[8:15] dmask:0x1 lwe ; encoding: [0x00,0x01,0x46,0xf0,0x06,0x0a,0x02,0x00]
// VI:   image_atomic_add v10, v6, s[8:15] dmask:0x1 lwe ; encoding: [0x00,0x01,0x4a,0xf0,0x06,0x0a,0x02,0x00]

image_atomic_add v11, v7, s[8:15] dmask:0x1 da
// SICI: image_atomic_add v11, v7, s[8:15] dmask:0x1 da ; encoding: [0x00,0x41,0x44,0xf0,0x07,0x0b,0x02,0x00]
// VI:   image_atomic_add v11, v7, s[8:15] dmask:0x1 da ; encoding: [0x00,0x41,0x48,0xf0,0x07,0x0b,0x02,0x00]

image_atomic_swap v4, v[192:195], s[28:35] dmask:0x1 unorm glc
// SICI: image_atomic_swap v4, v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x3c,0xf0,0xc0,0x04,0x07,0x00]
// VI:   image_atomic_swap v4, v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x40,0xf0,0xc0,0x04,0x07,0x00]

image_atomic_cmpswap v[4:5], v[192:195], s[28:35] dmask:0x1 unorm glc
// SIIC: image_atomic_cmpswap v[4:5], v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x40,0xf0,0xc0,0x04,0x07,0x00]
// VI:   image_atomic_cmpswap v[4:5], v[192:195], s[28:35] dmask:0x1 unorm glc ; encoding: [0x00,0x31,0x44,0xf0,0xc0,0x04,0x07,0x00]