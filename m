Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74131AF39C
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:46:42 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2F6F910FC62D0;
	Sat, 18 Apr 2020 11:46:49 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3CE2D10FC62CE
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=VISMEuIrdwsT06Me0Ojm4dxgrzpFN+IXsxHmlBlB8Qk=; b=nqtHk9RcEHVzyndzlvZR0ApTMu
	IN1fIO34WRJMJqoiVj7+SryUcbwhljitvqy/ICpkyIIe3BbMMImIye+e0/hX/bK155cyiYWUCLYSi
	BtcqtD6RrusuGCd9kZzO2uiwoFPl/pFtQB+EGVC0bUi41qqnl4Vd22sCWLoaS3qMDLJU6B+8Y/b3B
	pwlcV/D8BHV05r1/Bqcf3oReONTpcDhMqDTzxTxGSy3/capPzIfLqB6dlPwacRlKAaiVeGpJyRWHw
	KugYiErRe0UugJTz9HVHOvQZE01XSsMXRBvnxI0dM+ehHI+0RgwUw4Yb5V/AkkYq+jOPkS4NBxqRm
	SktMceiA==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsU6-0002Y8-4x; Sat, 18 Apr 2020 18:46:34 +0000
Subject: Re: [PATCH 5/9] usb: fix empty-body warning in sysfs.c
To: Matthew Wilcox <willy@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-6-rdunlap@infradead.org>
 <20200418184409.GP5820@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3998d056-e115-4e36-2705-eea132cce7de@infradead.org>
Date: Sat, 18 Apr 2020 11:46:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418184409.GP5820@bombadil.infradead.org>
Content-Language: en-US
Message-ID-Hash: DSFAZNNJD4527DDQ4QCZTEIKB33T2DBJ
X-Message-ID-Hash: DSFAZNNJD4527DDQ4QCZTEIKB33T2DBJ
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DSFAZNNJD4527DDQ4QCZTEIKB33T2DBJ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/18/20 11:44 AM, Matthew Wilcox wrote:
> On Sat, Apr 18, 2020 at 11:41:07AM -0700, Randy Dunlap wrote:
>> +++ linux-next-20200327/drivers/usb/core/sysfs.c
>> @@ -1263,7 +1263,7 @@ void usb_create_sysfs_intf_files(struct
>>  	if (!alt->string && !(udev->quirks & USB_QUIRK_CONFIG_INTF_STRINGS))
>>  		alt->string = usb_cache_string(udev, alt->desc.iInterface);
>>  	if (alt->string && device_create_file(&intf->dev, &dev_attr_interface))
>> -		;	/* We don't actually care if the function fails. */
>> +		do_empty(); /* We don't actually care if the function fails. */
>>  	intf->sysfs_files_created = 1;
>>  }
> 
> Why not just?
> 
> +	if (alt->string)
> +		device_create_file(&intf->dev, &dev_attr_interface);
> 

Yes, looks good. Thanks.

-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
