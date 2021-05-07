Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B87375E7B
	for <lists+linux-nvdimm@lfdr.de>; Fri,  7 May 2021 03:41:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EC187100EBB6B;
	Thu,  6 May 2021 18:41:19 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=yizhan@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CE19D100EF276
	for <linux-nvdimm@lists.01.org>; Thu,  6 May 2021 18:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620351675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j8mAAI/o5+m3p8IBcYqwPsD4sTg8s4W4APDiyUvjzk=;
	b=NZ//OU4/P9bErU7LDAvIVxJa/vxyn6UOSvSMVhxdTWqZzM/kcKpkvrbsJpjWf8ZUW1jNJn
	Aroi94mh5A/vKU2GmDVuUBHBd+aTbECMxtkpmvAIiNq9iEJ5ZR44xlNId81lyR6UISLxCX
	fhK1VkklplyOf+3tSyLTKlpHZ7kRMFY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Racv7z04MNGHtX4hYRiJxg-1; Thu, 06 May 2021 21:41:12 -0400
X-MC-Unique: Racv7z04MNGHtX4hYRiJxg-1
Received: by mail-yb1-f199.google.com with SMTP id k15-20020a056902070fb02904f8633d41c4so2588789ybt.23
        for <linux-nvdimm@lists.01.org>; Thu, 06 May 2021 18:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4j8mAAI/o5+m3p8IBcYqwPsD4sTg8s4W4APDiyUvjzk=;
        b=ZHWeGInZXgdczNMz7892/9s+4Icz4FvRB4gR+RSWu/derVY2qew4lo3A2zF5FeWUDg
         jf71tRtxvC/u2tj2xpSM6uURoygWBggTHw+Yad2A48Fp4+GflG9i3Brf3TqWkjimOJJ3
         SIeQjDJtBpik8HnGw2rm4EKB4O5nrTzbHTpzwsQ6L8aqUws66o6Z0UCyjD/MoIH4pZDJ
         2qKHWvboihWpco84VvVR+qi2HbydSheKqrQ62s3xCvqUP5bBD9nA/wLjzDfsuHzFWRh3
         PCCKSrnVaIwhHH/KcmfdhulslA89AmR1nTlAdso5EhfG1wXiMVM6k4Se5nhKMflNBytG
         libQ==
X-Gm-Message-State: AOAM5313nP/pZAHA2a7wZ16C5Kep9vJsoxn1CUpPqVWe1CbqcdGV7yJ1
	WmrUm3vsi3OdTKbtGzIVTGR4uNcS1r9icQpDXflJ4pCDui+op7pNdAVzFY6r9GNGr3KN0ING/1b
	hm6Tx0qwXi6VIdV5lFufAyCVQvTf7SsRpnFbe
X-Received: by 2002:a25:4093:: with SMTP id n141mr10244490yba.133.1620351672247;
        Thu, 06 May 2021 18:41:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7ozdW9iEEZnhy0Hfj1ui3nQzAyakvQKh8G3OXfmE/Ywibo3k6TbqijMUPZCw/RB1fxZYooAzH5KF2B3SiYiM=
X-Received: by 2002:a25:4093:: with SMTP id n141mr10244475yba.133.1620351672078;
 Thu, 06 May 2021 18:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs9s25EqRhL6_D5Rg_7j14N5UVODJ0ps4=4n7sZ6zE5U3w@mail.gmail.com>
 <CAPcyv4iuA=+aUOgHvYXtg8D_1RSxjrZC4cG2GXVhEZVeQCD5rA@mail.gmail.com>
 <CAHj4cs_Zp85ePses2CxuNyoh5FAObWxOuWGAmmOeZ1KOTQ6msQ@mail.gmail.com>
 <MWHPR11MB1599C0D93E6535796F3E0F21F0589@MWHPR11MB1599.namprd11.prod.outlook.com>
 <CAPcyv4g8+JHem1dJy4Hnf0eu0LfCX59u9Zta9AEXXRSa835GyA@mail.gmail.com>
In-Reply-To: <CAPcyv4g8+JHem1dJy4Hnf0eu0LfCX59u9Zta9AEXXRSa835GyA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 7 May 2021 09:41:00 +0800
Message-ID: <CAHj4cs9Xtfe8F92t8B433QFu19MaQeKnfpdti=oOC9c4e-THDg@mail.gmail.com>
Subject: Re: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0 [nfit]
 during boot
To: Dan Williams <dan.j.williams@intel.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Message-ID-Hash: TSIYDWICW37YDWJQYDCFZANG27NS4TT2
X-Message-ID-Hash: TSIYDWICW37YDWJQYDCFZANG27NS4TT2
X-MailFrom: yizhan@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Kaneda, Erik" <erik.kaneda@intel.com>, "Moore, Robert" <robert.moore@intel.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, nvdimm@lists.linux.dev
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TSIYDWICW37YDWJQYDCFZANG27NS4TT2/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, May 7, 2021 at 5:17 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Thu, May 6, 2021 at 10:28 AM Kaneda, Erik <erik.kaneda@intel.com> wrote:
> >
> >
> >
> > > -----Original Message-----
> > > From: Yi Zhang <yi.zhang@redhat.com>
> > > Sent: Wednesday, May 5, 2021 8:05 PM
> > > To: Williams, Dan J <dan.j.williams@intel.com>; Moore, Robert
> > > <robert.moore@intel.com>
> > > Cc: linux-nvdimm <linux-nvdimm@lists.01.org>; Kaneda, Erik
> > > <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> > > Subject: Re: [bug report] system panic at nfit_get_smbios_id+0x6e/0xf0
> > > [nfit] during boot
> > >
> > > On Sat, May 1, 2021 at 2:05 PM Dan Williams <dan.j.williams@intel.com>
> > > wrote:
> > > >
> > > > On Fri, Apr 30, 2021 at 7:28 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> > > > >
> > > > > Hi
> > > > >
> > > > > With the latest Linux tree, my DCPMM server boot failed with the
> > > > > bellow panic log, pls help check it, let me know if you need any test
> > > > > for it.
> > > >
> > > > So v5.12 is ok but v5.12+ is not?
> > > >
> > > > Might you be able to bisect?
> > >
> > > Hi Dan
> > > This issue was introduced with this patch, let me know if you need more info.
> > >
> > > commit cf16b05c607bd716a0a5726dc8d577a89fdc1777
> > > Author: Bob Moore <robert.moore@intel.com>
> > > Date:   Tue Apr 6 14:30:15 2021 -0700
> > >
> > >     ACPICA: ACPI 6.4: NFIT: add Location Cookie field
> > >
> > >     Also, update struct size to reflect these changes in nfit core driver.
> > >
> > >     ACPICA commit af60199a9a1de9e6844929fd4cc22334522ed195
> > >
> > >     Link: https://github.com/acpica/acpica/commit/af60199a
> > >     Cc: Dan Williams <dan.j.williams@intel.com>
> > >     Signed-off-by: Bob Moore <robert.moore@intel.com>
> > >     Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> > >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> >
> > It's likely that this change forced the nfit driver's code to parse the ACPI table so that it assumes that the location cookie field is always enabled and the NFIT was parsed incorrectly. Does the NFIT table on this platform contain a valid cookie field?
> >
>
> This was my fault. When I saw the size change fly by, I should have
> remembered to go update all the places that do "sizeof(struct
> acpi_nfit_system_address)".
>
> Yi Zhang, can you give the attached patch a try:

Hi Dan
My DCPMM server boots up now with this patch, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
