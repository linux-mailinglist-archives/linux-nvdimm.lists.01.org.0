Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC548271CE7
	for <lists+linux-nvdimm@lfdr.de>; Mon, 21 Sep 2020 10:03:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 029CA143DA0EE;
	Mon, 21 Sep 2020 01:03:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:4f8:190:11c2::b:1457; helo=mail.skyhub.de; envelope-from=bp@alien8.de; receiver=<UNKNOWN> 
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 9C7C4143DA0EB
	for <linux-nvdimm@lists.01.org>; Mon, 21 Sep 2020 01:03:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07e300bb1cec778fd9588d.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:bb1c:ec77:8fd9:588d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25AA91EC0323;
	Mon, 21 Sep 2020 10:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1600675385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
	bh=u0PtQQQAXwkJj9Jp5bddDDAFJrRvVWthWJTVhvKTM7s=;
	b=etuMCjtHT365s0kjpzNibtHMLsfFTib1t+oubn7NL5L+cPtT/CKb30gyZr1Uu8P8/cqP5c
	+pGho+L/5ItOAc1KLuBZm8FMGKk/ykiQ8swoBW45OgVUbww/2GhytoFn171dVogeGW+lVo
	RKMHi5MCgnCm7uN1XEUkmzJ+vn8GslY=
Date: Mon, 21 Sep 2020 10:02:58 +0200
From: Borislav Petkov <bp@alien8.de>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: PROBLEM: 5.9.0-rc6 fails =?utf-8?Q?to_?=
 =?utf-8?Q?compile_due_to_'redefinition_of_=E2=80=98dax=5Fsupported?=
 =?utf-8?B?4oCZJw==?=
Message-ID: <20200921080258.GA5947@zn.tnic>
References: <20200921010359.GO3027113@arch-chirva.localdomain>
 <CA+G9fYtCg2KjdB2oBUDJ2DKAzUxq3u8ZnMY9Et-RG9Pnrmuf9w@mail.gmail.com>
 <20200921073218.GA3142611@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200921073218.GA3142611@kroah.com>
Message-ID-Hash: ISKHWVLVFSRRHRXWEF3TOLTOVTW4XXWG
X-Message-ID-Hash: ISKHWVLVFSRRHRXWEF3TOLTOVTW4XXWG
X-MailFrom: bp@alien8.de
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Naresh Kamboju <naresh.kamboju@linaro.org>, Stuart Little <achirvasub@gmail.com>, linux-nvdimm@lists.01.org, kernel list <linux-kernel@vger.kernel.org>, linux- stable <stable@vger.kernel.org>, Adrian Huang <ahuang12@lenovo.com>, Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com, mpatocka@redhat.com, lkft-triage@lists.linaro.org, Jan Kara <jack@suse.cz>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ISKHWVLVFSRRHRXWEF3TOLTOVTW4XXWG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, Sep 21, 2020 at 09:32:18AM +0200, Greg KH wrote:
> all my local builds are breaking now too with this :(
> 
> Was there a proposed patch anywhere for this?

I've disabled CONFIG_BLK_DEV_PMEM which allowed me to de-select those
two:

# CONFIG_DAX is not set
# CONFIG_FS_DAX is not set

and now it at least builds.

In order to avoid such breakage in the future, I'd suggest you guys to
run randconfigs on your stuff before sending, especially if the Kconfig
ifdeffery is not a trivial one like the DAX maze.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
