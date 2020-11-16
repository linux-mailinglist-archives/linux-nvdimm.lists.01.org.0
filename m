Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A20D2B5357
	for <lists+linux-nvdimm@lfdr.de>; Mon, 16 Nov 2020 22:03:14 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 675CE100EC1D4;
	Mon, 16 Nov 2020 13:03:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::341; helo=mail-wm1-x341.google.com; envelope-from=alx.manpages@gmail.com; receiver=<UNKNOWN> 
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A091D100EC1D3
	for <linux-nvdimm@lists.01.org>; Mon, 16 Nov 2020 13:03:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so658464wmi.0
        for <linux-nvdimm@lists.01.org>; Mon, 16 Nov 2020 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kIBok6LhmX2oON2re8xwKd0vvOgtGJnjM3IpLHusadw=;
        b=TKwV9k+FZKUd2LAwXA+k72FWcs+EPrCRoALmGFbD1zvuHvxTQ+SSqk553M+WEdyPNp
         UmdIZ88Rz6NEybpakhEMzRK+Ex8y/oxuPDgYrUWPK8ORLJ4vfIj5IMSnSW1s/xpgxPhu
         l/9tL8fSIFraFFAnx1wLnxtKybQO2iFuutx+KxjMJJBHWrHfivKaN7s/aBUVJ5dCQo5a
         XpeLRtYnvT99t9llbCTi70/dwIH2b0v8T76uTZLzqhr1a/fXg20tXBKmLtyGtfyq9TAO
         ZlYZGmGgiO/ido1nqu2l+9NLu7Tpe8zdX+RBqaX6CjR6AzsxcijUPQQdvL1Hcr5GFp7O
         iNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kIBok6LhmX2oON2re8xwKd0vvOgtGJnjM3IpLHusadw=;
        b=qrU9/9QVhE0pee7ar8mQTYqdUppKHavBwhn8OvuAYQZ/VsKZ6LYyK6Z4SIBBjKX558
         01IUnJTMWqwQXVskabq5CNxk1C1CA/lCXa8qtHmUALK7ayntmRo4Pi8S+wjM52bxXbOZ
         6i4xL/2VJM+3efSDh6UOeOfMr1QbqqbuWf52wiKk9u03o68TtqPIlJirPRhodgv1zR4g
         U92JI5ScS8LaRqXlHubd0A0wFJYiMKv2Yftvqdglh8YH/RTYtw4ONyiMGrgdH2v3EIIY
         LwhLSub9MnVvm6IllHi9eacm7L+pNtBGyp7WL0ZGL2XlNQN2RRLlKnsEVwn93y4DIMi1
         quDA==
X-Gm-Message-State: AOAM531APyI7WhPQCt2P5cY5b43l4BYaIEjgrVVXpwc8zXM2/HJRuTup
	p7xWIB3ni1i0JYHDrRUf5w4=
X-Google-Smtp-Source: ABdhPJzOHhNlIpkSPa99BnwvG5LvoWEVPEOt0VC2sDFCF+lKYb8sZV+/i98RGOfuFhg4vt+8hd5CTg==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr813200wmf.160.1605560585749;
        Mon, 16 Nov 2020 13:03:05 -0800 (PST)
Received: from localhost.localdomain ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id p4sm24660325wrm.51.2020.11.16.13.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 13:03:05 -0800 (PST)
From: Alejandro Colomar <alx.manpages@gmail.com>
To: rppt@kernel.org,
	mtk.manpages@gmail.com
Subject: [PATCH v2] memfd_secret.2: New page describing memfd_secret() system call
Date: Mon, 16 Nov 2020 22:01:37 +0100
Message-Id: <20201116210136.12390-1-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201005073242.GA4251@kernel.org>
References: <20201005073242.GA4251@kernel.org>
MIME-Version: 1.0
Message-ID-Hash: 652BQHCWFK2VY2WGAELB5GUMAGHJ2S3A
X-Message-ID-Hash: 652BQHCWFK2VY2WGAELB5GUMAGHJ2S3A
X-MailFrom: alx.manpages@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@linux.ibm.com>, akpm@linux-foundation.org, arnd@arndb.de, bp@alien8.de, catalin.marinas@arm.com, cl@linux.com, colomar.6.4.3@gmail.com, dave.hansen@linux.intel.com, david@redhat.com, elena.reshetova@intel.com, hpa@zytor.com, idan.yaniv@ibm.com, jejb@linux.ibm.com, kirill@shutemov.name, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, palmer@dabbelt.com, paul.walmsley@sifive.com, peterz@infradead.org, shuah@kernel.org, tglx@linutronix.de, tycho@tycho.ws, viro@zeniv.linux.org.uk, will@kernel.org, willy@infradead.org, x86@kernel.org, Alejandro Colomar <alx.manpages@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/652BQHCWFK2VY2WGAELB5GUMAGHJ2S3A/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: Mike Rapoport <rppt@linux.ibm.com>

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Cowritten-by: Alejandro Colomar <alx.manpages@gmail.com>
Acked-by: Alejandro Colomar <alx.manpages@gmail.com>
Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---

Hi Mike,

I added that note about not having a wrapper,
fixed a few minor formatting and wording issues,
and sorted ERRORS alphabetically.

Cheers,

Alex

 man2/memfd_secret.2 | 178 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)
 create mode 100644 man2/memfd_secret.2

diff --git a/man2/memfd_secret.2 b/man2/memfd_secret.2
new file mode 100644
index 000000000..4e617aa0e
--- /dev/null
+++ b/man2/memfd_secret.2
@@ -0,0 +1,178 @@
+.\" Copyright (c) 2020, IBM Corporation.
+.\" Written by Mike Rapoport <rppt@linux.ibm.com>
+.\"
+.\" Based on memfd_create(2) man page
+.\" Copyright (C) 2014 Michael Kerrisk <mtk.manpages@gmail.com>
+.\" and Copyright (C) 2014 David Herrmann <dh.herrmann@gmail.com>
+.\"
+.\" %%%LICENSE_START(GPLv2+)
+.\"
+.\" This program is free software; you can redistribute it and/or modify
+.\" it under the terms of the GNU General Public License as published by
+.\" the Free Software Foundation; either version 2 of the License, or
+.\" (at your option) any later version.
+.\"
+.\" This program is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, see
+.\" <http://www.gnu.org/licenses/>.
+.\" %%%LICENSE_END
+.\"
+.TH MEMFD_SECRET 2 2020-08-02 Linux "Linux Programmer's Manual"
+.SH NAME
+memfd_secret \- create an anonymous file to map secret memory regions
+.SH SYNOPSIS
+.nf
+.B #include <linux/secretmem.h>
+.PP
+.BI "int memfd_secret(unsigned long " flags ");"
+.fi
+.PP
+.IR Note :
+There is no glibc wrapper for this system call; see NOTES.
+.SH DESCRIPTION
+.BR memfd_secret ()
+creates an anonymous file and returns a file descriptor that refers to it.
+The file can only be memory-mapped;
+the memory in such mapping
+will have stronger protection than usual memory mapped files,
+and so it can be used to store application secrets.
+Unlike a regular file, a file created with
+.BR memfd_secret ()
+lives in RAM and has a volatile backing storage.
+Once all references to the file are dropped, it is automatically released.
+The initial size of the file is set to 0.
+Following the call, the file size should be set using
+.BR ftruncate (2).
+.PP
+The memory areas obtained with
+.BR mmap (2)
+from the file descriptor are exclusive to the owning context.
+These areas are removed from the kernel page tables
+and only the page table of the process holding the file descriptor
+maps the corresponding physical memory.
+.PP
+The following values may be bitwise ORed in
+.IR flags
+to control the behavior of
+.BR memfd_secret (2):
+.TP
+.BR FD_CLOEXEC
+Set the close-on-exec flag on the new file descriptor.
+See the description of the
+.B O_CLOEXEC
+flag in
+.BR open (2)
+for reasons why this may be useful.
+.PP
+.TP
+.BR SECRETMEM_UNCACHED
+In addition to excluding memory areas from the kernel page tables,
+mark the memory mappings uncached in the page table of the owning process.
+Such mappings can be used to prevent speculative loads
+and cache-based side channels.
+This mode of
+.BR memfd_secret ()
+is not supported on all architectures.
+.PP
+See also NOTES below.
+.PP
+As its return value,
+.BR memfd_secret ()
+returns a new file descriptor that can be used to refer to an anonymous file.
+This file descriptor is opened for both reading and writing
+.RB ( O_RDWR )
+and
+.B O_LARGEFILE
+is set for the file descriptor.
+.PP
+With respect to
+.BR fork (2)
+and
+.BR execve (2),
+the usual semantics apply for the file descriptor created by
+.BR memfd_secret ().
+A copy of the file descriptor is inherited by the child produced by
+.BR fork (2)
+and refers to the same file.
+The file descriptor is preserved across
+.BR execve (2),
+unless the close-on-exec flag has been set.
+.PP
+The memory regions backed with
+.BR memfd_secret ()
+are locked in the same way as
+.BR mlock (2),
+however the implementation will not try to
+populate the whole range during the
+.BR mmap ()
+call.
+The amount of memory allowed for memory mappings
+of the file descriptor obeys the same rules as
+.BR mlock (2)
+and cannot exceed
+.BR RLIMIT_MEMLOCK .
+.SH RETURN VALUE
+On success,
+.BR memfd_secret ()
+returns a new file descriptor.
+On error, \-1 is returned and
+.I errno
+is set to indicate the error.
+.SH ERRORS
+.TP
+.B EINVAL
+.I flags
+included unknown bits.
+.TP
+.B EMFILE
+The per-process limit on the number of open file descriptors has been reached.
+.TP
+.B EMFILE
+The system-wide limit on the total number of open files has been reached.
+.TP
+.B ENOMEM
+There was insufficient memory to create a new anonymous file.
+.TP
+.B ENOSYS
+.BR memfd_secret ()
+is not implemented on this architecture.
+.SH VERSIONS
+The
+.BR memfd_secret (2)
+system call first appeared in Linux 5.X;
+.SH CONFORMING TO
+The
+.BR memfd_secret (2)
+system call is Linux-specific.
+.SH NOTES
+The
+.BR memfd_secret (2)
+system call provides an ability to hide information
+from the operating system.
+Normally Linux userspace mappings are protected from other users,
+but they are visible to privileged code.
+The mappings created using
+.BR memfd_secret ()
+are hidden from the kernel as well.
+.PP
+If an architecture supports
+.BR SECRETMEM_UNCACHED ,
+the mappings also have protection from speculative execution vulnerabilties,
+at the expense of increased memory access latency.
+Care should be taken when using
+.B SECRETMEM_UNCACHED
+to avoid degrading application performance.
+.PP
+Glibc does not provide a wrapper for this system call; call it using
+.BR syscall (2).
+.SH SEE ALSO
+.BR fcntl (2),
+.BR ftruncate (2),
+.BR mlock (2),
+.BR mmap (2),
+.BR setrlimit (2)
-- 
2.29.2
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
