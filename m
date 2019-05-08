Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE8D16E9B
	for <lists+linux-nvdimm@lfdr.de>; Wed,  8 May 2019 03:25:19 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0CA8A2125583C;
	Tue,  7 May 2019 18:25:17 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.20; helo=mga02.intel.com;
 envelope-from=vishal.l.verma@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 7F8BF2121AA3A
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 18:25:14 -0700 (PDT)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 May 2019 18:25:13 -0700
X-ExtLoop1: 1
Received: from vverma7-desk1.lm.intel.com ([10.232.112.185])
 by fmsmga001.fm.intel.com with ESMTP; 07 May 2019 18:25:13 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <linux-nvdimm@lists.01.org>
Subject: [ndctl PATCH] contrib: add an example qemu setup script for HMAT
 emulation
Date: Tue,  7 May 2019 19:25:05 -0600
Message-Id: <20190508012505.28543-1-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Add a script to demonstrate HMAT emulation using qemu by injecting the
initramfs with a made-up ACPI HMAT table.

Cc: Dan Williams <dan.j.williams@intel.com>
Originally-authored-by: Keith Busch <keith.busch@intel.com>
[vishal: minor shellcheck fixups]
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 contrib/daxctl-qemu-hmat-setup | 211 +++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100755 contrib/daxctl-qemu-hmat-setup

diff --git a/contrib/daxctl-qemu-hmat-setup b/contrib/daxctl-qemu-hmat-setup
new file mode 100755
index 0000000..0670e99
--- /dev/null
+++ b/contrib/daxctl-qemu-hmat-setup
@@ -0,0 +1,211 @@
+#!/bin/bash -e
+
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2019 Intel Corporation. All rights reserved.
+
+KERNEL=${KERNEL:-$(uname -r)}
+ROOT_IMAGE=${ROOT_IMAGE:-root.img}
+
+INITIATORS=4
+TARGETS=128
+TARGET_SIZE_MB=128
+TARGET_SIZE="$((TARGET_SIZE_MB * 1024 * 1024))"
+QEMU_MEM="$((TARGET_SIZE_MB * TARGETS))"
+
+for i in $(seq 0 $((TARGETS - 1))); do
+  qemu-img create -f raw "dimm-$i" "${TARGET_SIZE}"
+done;
+
+# Address Range Structures
+cat <<EOF > hmat.dsl
+                       Signature : "HMAT"    [Heterogeneous Memory Attributes Table]
+                    Table Length : 00000200
+                        Revision : 01
+                        Checksum : F4
+                          Oem ID : "BOCHS "
+                    Oem Table ID : "BXPCHMAT"
+                    Oem Revision : 00000001
+                 Asl Compiler ID : "INTL"
+           Asl Compiler Revision : 20170929
+                        Reserved : 00000000
+
+                  Structure Type : 0000 [Memory Subystem Address Range]
+                        Reserved : 0000
+                          Length : 00000028
+           Flags (decoded below) : 0003
+Processor Proximity Domain Valid : 1
+   Memory Proximity Domain Valid : 1
+                Reservation Hint : 0
+                       Reserved1 : 0000
+      Processor Proximity Domain : 00000000
+         Memory Proximity Domain : 00000000
+                       Reserved2 : 00000000
+     Physical Address Range Base : 0000000000000000
+     Physical Address Range Size : 00000000000A0000
+
+                  Structure Type : 0000 [Memory Subystem Address Range]
+                        Reserved : 0000
+                          Length : 00000028
+           Flags (decoded below) : 0003
+Processor Proximity Domain Valid : 1
+   Memory Proximity Domain Valid : 1
+                Reservation Hint : 0
+                       Reserved1 : 0000
+      Processor Proximity Domain : 00000000
+         Memory Proximity Domain : 00000000
+                       Reserved2 : 00000000
+     Physical Address Range Base : 0000000000100000
+     Physical Address Range Size : 0000000007F00000
+EOF
+
+for i in $(seq 1 $((TARGETS - 1))); do
+  BASE=$(printf "%016x" $((0x8000000 * i)))
+cat <<EOF >> hmat.dsl
+
+                  Structure Type : 0000 [Memory Subystem Address Range]
+                        Reserved : 0000
+                          Length : 00000028
+           Flags (decoded below) : 0003
+Processor Proximity Domain Valid : 1
+   Memory Proximity Domain Valid : 1
+                Reservation Hint : 0
+                       Reserved1 : 0000
+      Processor Proximity Domain : $(printf "%08x" $((i % INITIATORS)))
+         Memory Proximity Domain : $(printf "%08x" "${i}")
+                       Reserved2 : 00000000
+     Physical Address Range Base : ${BASE}
+     Physical Address Range Size : 0000000008000000
+EOF
+done
+
+# System Locality Latency
+TABLE_SIZE="$(printf "%08x" $((40 + 4 * INITIATORS + 4 * TARGETS + 2 * INITIATORS * TARGETS)))"
+cat <<EOF >> hmat.dsl
+
+                  Structure Type : 0001 [System Locality Latency and Bandwidth Information]
+                        Reserved : 0000
+                          Length : ${TABLE_SIZE}
+           Flags (decoded below) : 00
+                Memory Hierarchy : 0
+                       Data Type : 00
+                       Reserved1 : 0000
+   Initiator Proximity Domains # : $(printf "%08x" ${INITIATORS})
+      Target Proximity Domains # : $(printf "%08x" ${TARGETS})
+                       Reserved2 : 00000000
+                 Entry Base Unit : 0000000000000001
+EOF
+
+for i in $(seq 0 $((INITIATORS - 1))); do
+cat <<EOF >> hmat.dsl
+ Initiator Proximity Domain List : $(printf "%08x" "${i}")
+EOF
+done
+
+for i in $(seq 0 $((TARGETS - 1))); do
+cat <<EOF >> hmat.dsl
+    Target Proximity Domain List : $(printf "%08x" "${i}")
+EOF
+done
+
+LOCAL_START=0x10
+REMOTE_START=0x20
+for i in $(seq 0 $((INITIATORS - 1))); do
+  for j in $(seq 0 $((TARGETS - 1))); do
+    if [ "$((j % INITIATORS))" -eq "${i}" ]; then
+      cat <<EOF >> hmat.dsl
+                           Entry : $(printf "%04x" $((LOCAL_START + j * 10)))
+EOF
+    else
+      cat <<EOF >> hmat.dsl
+                           Entry : $(printf "%04x" $((REMOTE_START + j * 10)))
+EOF
+    fi
+  done
+done
+
+# System Locality Bandwidth
+TABLE_SIZE=$(printf "%08x" $((40 + 4 * INITIATORS + 4 * TARGETS + 2 * INITIATORS * TARGETS)))
+cat <<EOF >> hmat.dsl
+
+                  Structure Type : 0001 [System Locality Latency and Bandwidth Information]
+                        Reserved : 0000
+                          Length : ${TABLE_SIZE}
+           Flags (decoded below) : 00
+                Memory Hierarchy : 0
+                       Data Type : 03
+                       Reserved1 : 0000
+   Initiator Proximity Domains # : $(printf "%08x" ${INITIATORS})
+      Target Proximity Domains # : $(printf "%08x" ${TARGETS})
+                       Reserved2 : 00000000
+                 Entry Base Unit : 0000000000000400
+EOF
+
+for i in $(seq 0 $((INITIATORS - 1))); do
+cat <<EOF >> hmat.dsl
+ Initiator Proximity Domain List : $(printf "%08x" "${i}")
+EOF
+done
+
+for i in $(seq 0 $((TARGETS - 1))); do
+cat <<EOF >> hmat.dsl
+    Target Proximity Domain List : $(printf "%08x" "${i}")
+EOF
+done
+
+LOCAL_START=0x2000
+REMOTE_START=0x1000
+for i in $(seq 0 $((INITIATORS - 1))); do
+  for j in $(seq 0 $((TARGETS - 1))); do
+    if [ "$((j % INITIATORS))" -eq "${i}" ]; then
+      cat <<EOF >> hmat.dsl
+                           Entry : $(printf "%04x" $((LOCAL_START - j * 32)))
+EOF
+    else
+      cat <<EOF >> hmat.dsl
+                           Entry : $(printf "%04x" $((REMOTE_START - j * 32)))
+EOF
+    fi
+  done
+done
+
+# Side Caches
+for i in $(seq 0 ${TARGETS}); do
+cat <<EOF >> hmat.dsl
+
+                  Structure Type : 0002 [Memory Side Cache Information Structure]
+                        Reserved : 0000
+                          Length : 00000020
+         Memory Proximity Domain : $(printf "%08x" "${i}")
+                       Reserved1 : 00000000
+          Memory Side Cache Size : 0000000000100000
+Cache Attributes (decoded below) : 01001113
+              Total Cache Levels : 1
+                     Cache Level : 1
+             Cache Associativity : 1
+                    Write Policy : 1
+                 Cache Line Size : 0100
+                       Reserved2 : 0000
+                 SMBIOS Handle # : 0000
+EOF
+done
+
+# Generate injected initrd
+iasl ./*dsl
+mkdir -p kernel/firmware/acpi/
+rm -f kernel/firmware/acpi/*.aml hmat-initramfs
+cp ./*aml kernel/firmware/acpi/
+find kernel | cpio -c -o > hmat-initramfs
+cat "/boot/initramfs-${KERNEL}.img" >> hmat-initramfs
+
+# Build and evaluate QEMU command line
+QEMU="qemu-system-x86_64 -m ${QEMU_MEM} -smp 8,sockets=${INITIATORS},maxcpus=8 -machine pc,accel=kvm "
+QEMU+="-enable-kvm -display none -nographic -snapshot -hda ${ROOT_IMAGE} "
+QEMU+="-kernel /boot/vmlinuz-${KERNEL} -initrd ./hmat-initramfs "
+QEMU+="-append \"console=tty0 console=ttyS0 root=/dev/sda rw\" "
+
+for i in $(seq 0 $((TARGETS - 1))); do
+  QEMU+="-object memory-backend-file,id=mem${i},share,mem-path=dimm-${i},size=${TARGET_SIZE_MB}M "
+  QEMU+="-numa node,nodeid=${i},memdev=mem${i} "
+done
+
+eval "${QEMU}"
-- 
2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
