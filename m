Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE3105690
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Nov 2019 17:09:17 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4319A100DC2C1;
	Thu, 21 Nov 2019 08:09:49 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3BDD8100DC2C0
	for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 08:09:48 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id n14so3611088oie.13
        for <linux-nvdimm@lists.01.org>; Thu, 21 Nov 2019 08:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=UE/6TT7HfPuj8S5WgeIZ69I021cjsb4qGDZt3qc9fk1IB5APVoH66ut51jVBes4iSW
         Aef0fLKZocovV80FGW/O+Gv57tCW1pRhplxGliybAKG42xLiMrtbqrEIgCZ6c+KmfCnf
         dgvaBxYJ35Q4ov8s6LeUCSJ9dYGNH8PcnuIi4h6Cd61vCgrzzcoQi7EHEGMv6fGYmXFq
         ZiKVURucVh43UjBdWpw4DNKYA1CKXYHftPdvH2B0cR4G3F+T+udGHGGCvHw31xJf3qSy
         xTb97wVqCQKA608tb1v79CHsPYi02hOh3NrGphXwbN+jVtzlRPeKPQCB+mCUZPdYStwN
         m24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXcgcbvs+2MnPA/4X38cmSpaLsc4tBMazAvEwqgqGLo=;
        b=PnVntD+oNTpXoV95+0+hK6ynhaUQyNaMCTdLakAa234jT/PqyF7AgDONt1Cz1uUsKk
         xWJgbl64QMnIKAdWcPshUlSdpw0eBs6FaraVipOtzcOH72+Bh78e6QJFygyqwPmFFiNO
         uuD9BVanaj8nfQQnlNUHPMNVAGpgUeakmuoDK2h37Hgs+iwDWArfTIJC2ZjiP7oGqm1b
         8EsxtLzXiOD37cGIB8UqNscA/IApiL6yXj6YsHrVyMrc7/Bey6vgdvad0L1jUxHeyi6F
         X6dOyxJWIxheB3n4kQEi2vS3bRjn6ijXzqwnED2U/8ecpbQVXWE/plosYKH86H23cTrs
         y7KA==
X-Gm-Message-State: APjAAAUrhoBqpLDozqrr6+clKX7tcwSbzVF+M3CM+PZrTc24/8hGRuUm
	HxgykjZaX9X9+6ISzZOEWODwRPGkXjBJ97eun+Exeg==
X-Google-Smtp-Source: APXvYqwkBEKt2Ayxyhbxss+ahZZeyKGZ4wQSytQ1j5jmWgdtz59MSNkUesIZGAabUlJVAxO+Bd8N8I04KKrwKi4VgcA=
X-Received: by 2002:aca:3c1:: with SMTP id 184mr7837409oid.70.1574352553381;
 Thu, 21 Nov 2019 08:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
 <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
 <CAPcyv4hJ6gHX=NYz-CoXFSrN93HUT+Xh+DP+QAjzqgGmmghmGA@mail.gmail.com> <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
In-Reply-To: <1617854972.35808055.1574323227395.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 21 Nov 2019 08:09:02 -0800
Message-ID: <CAPcyv4haUOM92uzCBfVyrANxnNHKucivq053MFBmGOL3vqMgwQ@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID-Hash: YP2GML3G3EIZK3A5KALGP4GNZD5HLPOF
X-Message-ID-Hash: YP2GML3G3EIZK3A5KALGP4GNZD5HLPOF
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/YP2GML3G3EIZK3A5KALGP4GNZD5HLPOF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 21, 2019 at 12:00 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> > > >
> > > > >  Remove logic to create child bio in the async flush function which
> > > > >  causes child bio to get executed after parent bio 'pmem_make_request'
> > > > >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> > > > >  data write request.
> > > > >
> > > > >  Instead we are performing flush from the parent bio to maintain the
> > > > >  correct order. Also, returning from function 'pmem_make_request' if
> > > > >  REQ_PREFLUSH returns an error.
> > > > >
> > > > > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > > > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > >
> > > > There's a slight change in behavior for the error path in the
> > > > virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> > > > converted to -EIO.  Now, they are reported as-is.  I think this is
> > > > actually an improvement.
> > > >
> > > > I'll also note that the current behavior can result in data corruption,
> > > > so this should be tagged for stable.
> > >
> > > I added that and was about to push this out, but what about the fact
> > > that now the guest will synchronously wait for flushing to occur. The
> > > goal of the child bio was to allow that to be an I/O wait with
> > > overlapping I/O, or at least not blocking the submission thread. Does
> > > the block layer synchronously wait for PREFLUSH requests? If not I
> > > think a synchronous wait is going to be a significant performance
> > > regression. Are there any numbers to accompany this change?
> >
> > Why not just swap the parent child relationship in the PREFLUSH case?
>
> I we are already inside parent bio "make_request" function and we create child
> bio. How we exactly will swap the parent/child relationship for PREFLUSH case?
>
> Child bio is queued after parent bio completes.

Sorry, I didn't quite mean with bio_split, but issuing another request
in front of the real bio. See md_flush_request() for inspiration.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
