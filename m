Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED26361BC2
	for <lists+linux-nvdimm@lfdr.de>; Fri, 16 Apr 2021 10:59:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3F6C7100EBB6E;
	Fri, 16 Apr 2021 01:59:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.216.45; helo=mail-pj1-f45.google.com; envelope-from=andy.shevchenko@gmail.com; receiver=<UNKNOWN> 
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C4894100EBB6C
	for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 01:59:20 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so15999847pjh.1
        for <linux-nvdimm@lists.01.org>; Fri, 16 Apr 2021 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyksKIc0n99yyssJwpLodM7su3j1qqWMI7llYytjMLA=;
        b=s4ZUhAbBBYMQyBJ8UDvVDeZfS5T6fksET6rRhsvhjsuO6o3xLhSRkRfgdwPf45TSVt
         pdUXmhclFsQj28vfKUwd48QFri5adJPKCM/nfO9UBrOWI4F/Rbm10wzm7n3V1jQnhXqp
         7WwWLaC7Ga0GS+2v4M1QX9EeiC0ItGg2HLBlwv1/esC4e3QCxDQmKWT0Fsr8nwa27f4T
         Fdb605eJp2cwUaWJU7eKDOfoPxGF+NwiucwhdBoANDEi36avGNTAmbkQDiHuSUwwkDHQ
         5T/0vwGnOVbEB9VT2Nh4p098lRh49sfXouYX1Mc1ey/gviRCYQeMRDhjMdYGGpGGYCPI
         2JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyksKIc0n99yyssJwpLodM7su3j1qqWMI7llYytjMLA=;
        b=p8ByKJ2tX61MMhdEgxrOTR4Y8ssk8aHj+E0/IiA29a39rsTbzugbvxGUHJrDdeQoJ0
         GIpsdYPNR8QUAX4bhdQz38Bx6NhDEeIpLo4XD/7vXnu1Umhn/V4AkAgWJONDFq2l19Mt
         p9tLTuMrS64wA2bMG6DNCk7NAskorMKumizvIgHDBpMAEEABKoyUCGevQG+lgxC1R+zq
         iJelI1I4s0gHxWJBfXQ92D05tmp5hDKhQLEDSpj9M2HPc+j9Iwy6oI/2ov+15P38PKcn
         d5qn6AWhYdJQo6QbKjnNmS7hBVqkHeJCXg2U9JjeQg9/R4Gj5OoDgSRigvWm7AF/2sOp
         Cxyw==
X-Gm-Message-State: AOAM532xzQW6YSULmIYR5CjtKu0BwOk4M1gig1N7xUlK/eVd190/OQTi
	Ooh8fsbNrguRXOaUlMENXkUqvbKZUIFUTdsQRj6NBJ8R4cIU0g==
X-Google-Smtp-Source: ABdhPJxWGtnFV5kGAdlHfZ+DRtP1VYBmnDUF/0bodAjP5X1S1rLrqE8Hol9qraBAphaCkhMo5/rJQ+zW78879flvW8Q=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr8351889plq.17.1618563500287; Fri, 16 Apr
 2021 01:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210415135901.47131-1-andriy.shevchenko@linux.intel.com> <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jpkZNsQEvCe_dLoq0DOTrEX36vhkJg+zqEacUkJtvWiQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Apr 2021 11:58:04 +0300
Message-ID: <CAHp75VcpQREYFesS9q2TeqrR29hf0CvMESM42AVGAFzEYeRr_Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Import GUID before use
To: Dan Williams <dan.j.williams@intel.com>
Message-ID-Hash: 5OQ3RXIRNVJN5KNA6QCXI52BPXIICN5C
X-Message-ID-Hash: 5OQ3RXIRNVJN5KNA6QCXI52BPXIICN5C
X-MailFrom: andy.shevchenko@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5OQ3RXIRNVJN5KNA6QCXI52BPXIICN5C/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Apr 16, 2021 at 8:28 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, Apr 15, 2021 at 6:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Strictly speaking the comparison between guid_t and raw buffer
> > is not correct. Import GUID to variable of guid_t type and then
> > compare.
>
> Hmm, what about something like the following instead, because it adds
> safety. Any concerns about evaluating x twice in a macro should be
> alleviated by the fact that ARRAY_SIZE() will fail the build if (x) is
> not an array.

ARRAY_SIZE doesn't check type.
I don't like hiding ugly casts like this.


-- 
With Best Regards,
Andy Shevchenko
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
