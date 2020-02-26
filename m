Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F85B170B68
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Feb 2020 23:21:03 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 65B1A1007B162;
	Wed, 26 Feb 2020 14:21:53 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id A82501007B1EA
	for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 14:21:51 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id q81so1263587oig.0
        for <linux-nvdimm@lists.01.org>; Wed, 26 Feb 2020 14:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnVOCEsjBwOxoF8dOWv+bm/em7b8myvard+P6ns/3cw=;
        b=Lr3U2W0k9Vu/cAqSV71cDWrDv06ZHvhcUI5dagKdSyX+0jx8eMguvZujETA9VGnvQn
         /lhHPUxU2baQjL6J/mbzHOCxl6uIGf5DUSFC4EpSpZhXXtY85ckDlZngg/4jo6wpxoAd
         SlnckT85Sr0+dYEG3QTOZo5YNDf6ssFwYmZxsDW9ohYCTli3Vjq/nv4fh0UAxQaXopYx
         RL0M1uszwLR4CRDkkcLAdCRMUKQQOlVIDUTZAvuTIp3l4pp1tvlQG7NfLt8i6PXuuvTt
         nMas3PRRAuVfOdc/BGhmkZlt+boWUj+0Qxd+Dojjj1kL1EbMHzhNFcsx3o3PxpqkD2X+
         EdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnVOCEsjBwOxoF8dOWv+bm/em7b8myvard+P6ns/3cw=;
        b=KqHKGj8n+/C8jdi/RVV/ZPCBrX2RWCpW6RhSXmCp2NX5k2nWZgfEtC7j0GA+h/NyBH
         g3knn3qzyQ+SejiVHS4pfjjvhh0hs8YRVbNdgiIkLB5WvkPAPlIZhnQ7p1NcFTGtTF30
         cSfX6Q8n8FJI0QXkk4bDF/IOmlKEtbabg5i82lB9qW5o5/8XepiDXR7eFnFqLaLFEJWM
         e5rLos1qqQ9Lm12vlTM97AxjY69cLH2tpQip7yvG7XyRNYJLlz5lywlKdWCGcybKgk7D
         1cVd8UQobD+wMplGMN4I6Attj0wCZy4cZjZyAqundCc2fcrUdJ47sDUQJ8MLf7E4QyEO
         XMnw==
X-Gm-Message-State: APjAAAW3NUySvaqmhUXrKU1dVTz/GII8/nDflZg3O/TXaAJPtyA+4UCb
	wWtEoxq3RoQwOdob+AbxzF9GpDBSaAbQYyPQ7hoTjw==
X-Google-Smtp-Source: APXvYqzf7DwicPpoRXVo6ggKAII1e4xHUVpATEuwtGGtCsScq4W3t46M2n2J/u3VuQIAcRXWPhfkXi21KzH51LZc1Jo=
X-Received: by 2002:a54:4791:: with SMTP id o17mr982861oic.70.1582755658596;
 Wed, 26 Feb 2020 14:20:58 -0800 (PST)
MIME-Version: 1.0
References: <158042414995.3946705.2742716492944802875.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158042415512.3946705.18330231517256727320.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49o8tulai8.fsf@segfault.boston.devel.redhat.com> <CAPcyv4izzfzrb2r7Mc7FfryGnBcn1bOUA8a6_L9t2fKR4caoXw@mail.gmail.com>
 <x49y2sp3tka.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49y2sp3tka.fsf@segfault.boston.devel.redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 26 Feb 2020 14:20:47 -0800
Message-ID: <CAPcyv4j2D93E4AgzB7JN51e18L85zmkLGA3gCVdq5ovxXMhH0g@mail.gmail.com>
Subject: Re: [ndctl PATCH 1/2] ndctl/region: Support ndctl_region_{get, set}_align()
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID-Hash: PLIHEYONS24XUVG5QJQDLAE24MERTZ4E
X-Message-ID-Hash: PLIHEYONS24XUVG5QJQDLAE24MERTZ4E
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-nvdimm <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/PLIHEYONS24XUVG5QJQDLAE24MERTZ4E/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Feb 26, 2020 at 1:52 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> >> Missing doctext.  Specifically, there should be a big, fat warning
> >> against changing the region alignment.
> >
> > I don't mind adding one, but is this the right place to document an
> > API warning? If the audience is future ndctl developers that should be
> > warned to keep the status quo of not plumbing this capability into
> > "create-namespace" that's one message. If it's to stop other libndctl
> > application developers, they'll likely never see this source file.
>
> I meant to target users of the library (not ndctl developers).  I
> thought that was the reason for the doctext on exported interfaces.  No?
>
> I admit, I don't know how users of libndctl figure *anything* out about
> how to use it.  :)
>

Right, that's why I was confused about what you were asking. We
haven't yet formalized a library documentation system, which is bad.
I'll add kernel-doc for this function, and add an item to the backlog
to figure out how to build library-documentation from those
annotations. The developer's guide to date has unfortunately been "go
review how ndctl uses it".
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
