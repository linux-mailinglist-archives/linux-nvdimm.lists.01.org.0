Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3186A2917B9
	for <lists+linux-nvdimm@lfdr.de>; Sun, 18 Oct 2020 16:05:04 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EA7951252332A;
	Sun, 18 Oct 2020 07:05:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=216.205.24.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=trix@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 10BAD12523328
	for <linux-nvdimm@lists.01.org>; Sun, 18 Oct 2020 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1603029898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
	b=CE3TTm0ZWS3xUbYzjwLA7+TYTk7Dg+VxIL4Zp73oDsqTuzAXXNjBX0Doq5M5Cu6ffXkYev
	bZ3C9BpL47kMqRFuXYSmeuVfmCYD0R8cyybmNyMbwair6n3qDaCsRQ2KiiaxG8Fe9Zs8sm
	6xUrramWNvo4ZIP3aUKUh3vEKSsfIgI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-WXP8-6kfOYWe-b14avcttA-1; Sun, 18 Oct 2020 10:04:57 -0400
X-MC-Unique: WXP8-6kfOYWe-b14avcttA-1
Received: by mail-qk1-f197.google.com with SMTP id y77so5482868qkb.8
        for <linux-nvdimm@lists.01.org>; Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
        b=itbUMDoDmkcF4bb4sxTv3K2spbSgB4zEVWRtbiXHQ8H0gJ1lBOI98tgV9EGN5M78AD
         /VXts4nTQCiS+G04w04HN+7ZTF8c8NKig7WsPcZtdW4b34UG/wvoe8zfZGMtlo/Lp3ST
         pywXzTgvhRCo1ifnKl+uyI8HVmeSX6ZKE9rhjbx5wHPiBgJdAIlSvQH2zCmeHOzEENLd
         3I5wMDG+ALptgSHIfa61qCLwtgkob3jcmtDFbso0uJVfhDTjoS0Ylr+lJcsTpXmLt4we
         R8A++vNVU/lYDxUIey6Gry/tzFSbMyjKK0tDW1XqGSseseoeX0U4X7KXkJuer3u+bGoN
         yaKA==
X-Gm-Message-State: AOAM532XSVvpfyU6yiNzG/kZMTCnNXDkMQMg+0GfEdUzJbeqz7Jb3XKU
	AkycMNTGyoTOgBvKuli0vnS3qS18/gLVqANxd+hwDlWKMsI79ANbyIJyX1RflpzfDoUH/DLnE0A
	9xChH2f9tsAZfaFqG+pPe
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr12724348qki.436.1603029896605;
        Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6z5rS79nBj0nCbIqVRZ9qmkAzjArqewdITB0rtwnhi1UUe/kvxLZTENMJDRITA4iBlrUAlw==
X-Received: by 2002:a05:620a:1287:: with SMTP id w7mr12724258qki.436.1603029896034;
        Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u16sm3288927qth.42.2020.10.18.07.04.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 07:04:55 -0700 (PDT)
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <eecb7c3e-88b2-ec2f-0235-280da51ae69c@redhat.com>
Date: Sun, 18 Oct 2020 07:04:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201018054332.GB593954@kroah.com>
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Message-ID-Hash: WEJIZRIEW65VZT77UHKHUQIX3C7G4VWA
X-Message-ID-Hash: WEJIZRIEW65VZT77UHKHUQIX3C7G4VWA
X-MailFrom: trix@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, linux-block@vger.kernel.org, openipmi-developer@lists.sourceforge.net, linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-power@fi.rohmeurope.com, linux-gpio@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, industrypack-devel@lists.sourceforge.net, linux-media@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org, linux-mtd@lists.infradead.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org, ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-nfc@lists.01.org, linux-nvdimm@lists.01.org, linux-pci@vger.
 kernel.org, linux-samsung-soc@vger.kernel.org, platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com, storagedev@microchip.com, devel@driverdev.osuosl.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net, linux-watchdog@vger.kernel.org, ocfs2-devel@oss.oracle.com, bpf@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, alsa-devel@alsa-project.org, clang-built-linux@googlegroups.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WEJIZRIEW65VZT77UHKHUQIX3C7G4VWA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 10/17/20 10:43 PM, Greg KH wrote:
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This is a upcoming change to clean up a new warning treewide.
>> I am wondering if the change could be one mega patch (see below) or
>> normal patch per file about 100 patches or somewhere half way by collecting
>> early acks.
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.

OK.

Thanks,

Tom

>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...
>
> thanks,
>
> greg k-h
>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
