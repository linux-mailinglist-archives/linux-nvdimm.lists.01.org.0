Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C08226DC4
	for <lists+linux-nvdimm@lfdr.de>; Mon, 20 Jul 2020 20:09:16 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 9E6D7123C0AAE;
	Mon, 20 Jul 2020 11:09:13 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=212.227.126.130; helo=mout.kundenserver.de; envelope-from=arnd@arndb.de; receiver=<UNKNOWN> 
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id D3FA5123C0AAC
	for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 11:09:04 -0700 (PDT)
Received: from mail-io1-f50.google.com ([209.85.166.50]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MI59b-1k1Ai13Bfr-00FCB9 for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020
 20:09:02 +0200
Received: by mail-io1-f50.google.com with SMTP id k23so18563229iom.10
        for <linux-nvdimm@lists.01.org>; Mon, 20 Jul 2020 11:09:02 -0700 (PDT)
X-Gm-Message-State: AOAM532ZCC8MA7/mcCIPPeCkvh4zBWG4IZV7I8lmLnUV+pQDfKsSgESk
	CF79cR65jPc6U/eP3eNJO+cQaNJeztP2+KuCyjE=
X-Google-Smtp-Source: ABdhPJxk8AXvQoaaSyG6TPpWGlRFg6r3NFnqCF1QtWJiuwzUOgkiVS3DL9DQU7SzABQpPR/Um1zIkILDDVb8zZFAISI=
X-Received: by 2002:a37:b484:: with SMTP id d126mr22851253qkf.394.1595268540113;
 Mon, 20 Jul 2020 11:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200720092435.17469-1-rppt@kernel.org> <20200720092435.17469-4-rppt@kernel.org>
 <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com> <1595260305.4554.9.camel@linux.ibm.com>
In-Reply-To: <1595260305.4554.9.camel@linux.ibm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 20 Jul 2020 20:08:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
Message-ID: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
To: "James E.J. Bottomley" <jejb@linux.ibm.com>
X-Provags-ID: V03:K1:ohHpD+bg3lMLcpZOCloqg6b9r1+3Tl3EVXsnEKgE13Xrhixv4iA
 IDliSc+GmiEYdnSwO9oaM7/TrTztIp5+0GHYkmHHEZIBFcwJEGgwVz5A+VS5fk7D8eyjMx/
 O8txdiSb6aFtBIoLu21GJdgreszgAyyDAa0I7sWrdEbdiVTxmZUyXRfbu1anTS4seA7KQi5
 +MpuoHUNS8hBgvpfGo5xA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tvek4F3GAoQ=:fx7y8nuaizkbmPE7Bn6BlO
 +0UJxpHybHTK7a1RE69O2IRV+Yxci+lxLqapc8AqgO2y+j0oxEdq4nP8rdDlAKxf2z7CXEt4i
 Q45S2zMkFB1NuUtjrLx8W1ZwbLsrjae2PJ9qOyS3AUWjrzriSzG0/T5wzgoFVmO8a5MIgOJQC
 Fw0Wbb4qVEIdpLwkQPcdKBeQIWERQX+w4qHSySAjYGNLByi/YVWhtpONPkXKRjiZ+djcIVZG0
 xSv0v2glFQULp1E+5+Gr4cxT872GcjL1LO12KDsmgAGQLnNPEUvJbrQs6UilEJEj39ImM/IM4
 S6KznvFSJZeGMIr08hMbtnNouSSOQrsAzKVaYHHg7VvQ4mLHDNDjUX6UWorcY26BF8rsWSRUT
 EiTlWgIq+fEcUYKn+beAxP+cUy/h+Sbrxowfsu7uUIAFbI5jcl6vTjqS4ZBk8thVsAfoiRHY2
 C2QD8D9n5yfJzFAmv1a6ump+Fi/ejNB9B2gHgKkSsO/FGMlZy1R+bmHk2q9qgpvoX37p+hwr7
 sH8C2ivU3U1bwvukIJuVO7kpw+YSNz+O3xzpHwHjaQiRI1j4YqMqKFzV9H2UGV7d7K6IOBKvw
 bbxDJEOKxTGrxMn0jgYba/T1wRCK4d576Bw+qHuc+ufR+IMO8plVGE14lxCfa9uNQ0IDhmp1p
 Dq/F4wRf6pV+7BcN39qHv2Wmn0I3VMLSCD7XnOMrK+7fWRm9zAYCwb+PsHXdHiAR8++HGKV5m
 R0fY4jcQCSBz1eglGKPutAt8BTYLb++hxylH+zdr0mAVC8rD9gumR+5m66MadMBe9EHAEzAPP
 O38Mu8n/dtbcpZlUA/V2EF713xFerCZTMmdVBobgRARUDY9J9xpisZ5Jm+QqzSjqMVUB4C0MT
 ZgUW+S6VnC3/fPmlzc5lvy4wfd11jvNEmZ06cBST3ZaRplvM8DI/YOIFQ01WZ1stu70zdsjVX
 bcieOWRx722+BRdXfiPC/A10DfDYPY6HGTVMT++Jz91onkrM6Nwbr
Message-ID-Hash: ZDR5BCSWI6EU5EFGAWJ6L2LWP6OHGE5V
X-Message-ID-Hash: ZDR5BCSWI6EU5EFGAWJ6L2LWP6OHGE5V
X-MailFrom: arnd@arndb.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Mike Rapoport <rppt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christopher Lameter <cl@linux.com>, Dave Hansen <dave.hansen@linux.intel.com>, Elena Reshetova <elena.reshetova@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>, Ingo Molnar <mingo@redhat.com>, "Kirill A. Shutemov" <kirill@shutemov.name>, Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux FS-de
 vel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org, linux-riscv <linux-riscv@lists.infradead.org>, the arch/x86 maintainers <x86@kernel.org>, linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZDR5BCSWI6EU5EFGAWJ6L2LWP6OHGE5V/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com> wrote:
> On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
>
> I'll assume you mean the dmabuf userspace API?  Because the kernel API
> is completely device exchange specific and wholly inappropriate for
> this use case.
>
> The user space API of dmabuf uses a pseudo-filesystem.  So you mount
> the dmabuf file type (and by "you" I mean root because an ordinary user
> doesn't have sufficient privilege).  This is basically because every
> dmabuf is usable by any user who has permissions.  This really isn't
> the initial interface we want for secret memory because secret regions
> are supposed to be per process and not shared (at least we don't want
> other tenants to see who's using what).
>
> Once you have the fd, you can seek to find the size, mmap, poll and
> ioctl it.  The ioctls are all to do with memory synchronization (as
> you'd expect from a device backed region) and the mmap is handled by
> the dma_buf_ops, which is device specific.  Sizing is missing because
> that's reported by the device not settable by the user.

I was mainly talking about the in-kernel interface that is used for
sharing a buffer with hardware. Aside from the limited ioctls, anything
in the kernel can decide on how it wants to export a dma_buf by
calling dma_buf_export()/dma_buf_fd(), which is roughly what the
new syscall does as well. Using dma_buf vs the proposed
implementation for this is not a big difference in complexity.

The one thing that a dma_buf does is that it allows devices to
do DMA on it. This is either something that can turn out to be
useful later, or it is not. From the description, it sounded like
the sharing might be useful, since we already have known use
cases in which "secret" data is exchanged with a trusted execution
environment using the dma-buf interface.

If there is no way the data stored in this new secret memory area
would relate to secret data in a TEE or some other hardware
device, then I agree that dma-buf has no value.

> What we want is the ability to get an fd, set the properties and the
> size and mmap it.  This is pretty much a 100% overlap with the memfd
> API and not much overlap with the dmabuf one, which is why I don't
> think the interface is very well suited.

Does that mean you are suggesting to use additional flags on
memfd_create() instead of a new system call?

      Arnd
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
