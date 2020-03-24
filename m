Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE5190347
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Mar 2020 02:21:44 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 73BBA10FC3897;
	Mon, 23 Mar 2020 18:22:33 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7DDA710FC362D
	for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 18:22:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k8so16989733oik.2
        for <linux-nvdimm@lists.01.org>; Mon, 23 Mar 2020 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4Gkwa2G1ZvtAVtLLGAEnxqc8kb/47goUTTzJiwNkCw=;
        b=hdG3K0QGGf0OSVfqsu+FIJ5ZZAFSUtp6tH1qczcvKGNR9xYLbHKOG8boELnc4B1SgD
         d2aUAPTzFxP6R5O+d/Rjd/NhrqxLVARqIt6n5IxywosSeJ3LhNmEkYtaMc2y2fjr6o30
         Gg7M8th80lb65ZijeOO6hmL8DcJVMiPwqK9uryklEKAM/ZpNURuf1UThR01v8QkHj2Vm
         up7m+UTcQbiC7oOmUmKJ4Vhjgr5kjiG5phnPAZXBW7EfUyAWJPGSKQs9SnMRZUdcNSpH
         wKUV7f85qztZrSErNG/BD8aGSTBOugqWu+i86DCV8mM3B+JUZPlHGT8iY9zDrYZrY5hP
         KYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4Gkwa2G1ZvtAVtLLGAEnxqc8kb/47goUTTzJiwNkCw=;
        b=Eajnjls494m90vbqC16/LBEeycKAu+MlAvA15qynj4buAE8JX/Po2xdu/8w5ehReqM
         T0Gs9oODOGrjOvlnODGB4sEKOamecXeuv+Jll8ecCPU9r8oQ/Lw1nh5/wPjndWq+ZGuI
         NED/Bv/vTpq/0IFsktlsTp048Ej/KZ6f6uD+e8qFZsa8es3tSjeKhRl2vjQviiIla1Iu
         +DK5lC8b3KulPaDqBBJZumYhHum9r9MZVPk4y65d0QIB4MpNQMl70ybwHYqaf6A55z/P
         MTSWlV5EaUw4ZlvSZAW87d4wOPgBMGXMvv0XqX1uzFF1QmVt/KuKtVrkqOKxVgsz4m8J
         2sVg==
X-Gm-Message-State: ANhLgQ2btmgpaaBnMyJHZrMPDk7GACov82BJfJF5trErc1UR/9Zsuk2s
	7KkrY4wQJvYSoBfWLv7H0NhV1epQ30ZIEt1coOB9ng==
X-Google-Smtp-Source: ADFU+vtR+zfDGu6b9EvlKwPHbaugAQTL77/k93YOHOTwCOIL3riH+keQFZWvZt4YHPs0IL1wVEEMyLWti3Do08G4gIM=
X-Received: by 2002:aca:ef82:: with SMTP id n124mr1623535oih.73.1585012898928;
 Mon, 23 Mar 2020 18:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200205052056.74604-1-aneesh.kumar@linux.ibm.com>
 <CAPcyv4hBAk-dwO4=AT7cQm5YUwCBg0AECsZsiCjRJ_ZGWvWUAw@mail.gmail.com>
 <87y2ta8qy7.fsf@linux.ibm.com> <CAPcyv4hNV88FJybgoRyM=JuKgrwYaf+CLWfFWt5X3yFMrecU=Q@mail.gmail.com>
 <25eabdd9-410f-e4c3-6b0e-41a5e6daba10@linux.ibm.com> <CAPcyv4iFP6_jkocoyv-6zd0Y8FEYFA3Pk6brH5+_XQ9+U896wQ@mail.gmail.com>
 <87k13fnzt8.fsf@linux.ibm.com>
In-Reply-To: <87k13fnzt8.fsf@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Mar 2020 18:21:27 -0700
Message-ID: <CAPcyv4hfdOUvxDsCrBu05K0pmZ_spCOOiP3YyLLuFWW-HqT+LA@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: Update persistence domain value for of_pmem
 and papr_scm device
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID-Hash: LF7CW6WBBK4WDBFWSNVYWXABVLLBYKLP
X-Message-ID-Hash: LF7CW6WBBK4WDBFWSNVYWXABVLLBYKLP
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/LF7CW6WBBK4WDBFWSNVYWXABVLLBYKLP/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Mar 20, 2020 at 2:25 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
>
> Hi Dan,
>
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> ...
>
>
> >
> >>
> >> Or are you suggesting that application should not infer any of those
> >> details looking at persistence_domain value? If so what is the purpose
> >> of exporting that attribute?
> >
> > The way the patch was worded I thought it was referring to an explicit
> > mechanism outside cpu cache flushes, i.e. a mechanism that required a
> > driver call.
> >
>
> This patch is blocked because I am not expressing the details correctly.
> I updates this as below. Can you suggest if this is ok? If not what
> alternate wording do you suggest to document "memory controller"
>
>
> commit 329b46e88f8cd30eee4776b0de7913ab4d496bd8
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Date:   Wed Dec 18 13:53:16 2019 +0530
>
>     libnvdimm: Update persistence domain value for of_pmem and papr_scm device
>
>     Currently, kernel shows the below values
>             "persistence_domain":"cpu_cache"
>             "persistence_domain":"memory_controller"
>             "persistence_domain":"unknown"
>
>     "cpu_cache" indicates no extra instructions is needed to ensure the persistence
>     of data in the pmem media on power failure.
>
>     "memory_controller" indicates cpu cache flush instructions is required to flush
>     the data. Platform provides mechanisms to automatically flush outstanding
>     write data from memory controler to pmem on system power loss.
>
>     Based on the above use memory_controller for non volatile regions on ppc64.

Looks good to me, want to resend via git-format-patch?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
