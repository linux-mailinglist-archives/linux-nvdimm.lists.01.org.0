Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357F01AF3CB
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:53:12 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 29D8410FC62DB;
	Sat, 18 Apr 2020 11:53:18 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 57BFC10FC62DA
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=KGgaI7/aF8gM/DdPVeh3iRDUqP5nlN3BG5/ZUjntmeQ=; b=GwZqVX1hBQ8NWcNug1tIYKrz4R
	U2IRF1+FEjojk+ZQVifHKsqFCF+H1fiJMydhq8YjDjbW9KtWGwn3olr7vK/HGNSu1WehIvKQtWosh
	BMoPriJK/H+0lffwLs5E6nvv2/JNTOwtoaK7zBEb/dn8JEcPRvepUcxaZHR8H7DkIeSlWVcUS1WWV
	CVUMlz5qooHHwL7XywdUi73jCtHRZnEwK1/5MDK68fwQFNLP2YhETImwB/mvOFWt+m48ND+munIaR
	O+7wJI5R8Vlj3BiAZo2gPs9W/wVQEXfyqPWT2fnEqJLIFpbeht4HH8Yn4gA8r97+CDZtM4p+B4qCJ
	wy6wnDqA==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsaQ-0005zR-VX; Sat, 18 Apr 2020 18:53:07 +0000
Subject: Re: [PATCH 7/9] drivers/base: fix empty-body warnings in
 devcoredump.c
To: Matthew Wilcox <willy@infradead.org>
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-8-rdunlap@infradead.org>
 <20200418185033.GQ5820@bombadil.infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b88d6f8b-e6af-7071-cefa-dc12e79116b6@infradead.org>
Date: Sat, 18 Apr 2020 11:53:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200418185033.GQ5820@bombadil.infradead.org>
Content-Language: en-US
Message-ID-Hash: UIZANM6ZVMEUSJDL67EELZBL2BQ6HMM4
X-Message-ID-Hash: UIZANM6ZVMEUSJDL67EELZBL2BQ6HMM4
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UIZANM6ZVMEUSJDL67EELZBL2BQ6HMM4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/18/20 11:50 AM, Matthew Wilcox wrote:
> On Sat, Apr 18, 2020 at 11:41:09AM -0700, Randy Dunlap wrote:
>> @@ -294,11 +295,11 @@ void dev_coredumpm(struct device *dev, s
>>  
>>  	if (sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
>>  			      "failing_device"))
>> -		/* nothing - symlink will be missing */;
>> +		do_empty(); /* nothing - symlink will be missing */
>>  
>>  	if (sysfs_create_link(&dev->kobj, &devcd->devcd_dev.kobj,
>>  			      "devcoredump"))
>> -		/* nothing - symlink will be missing */;
>> +		do_empty(); /* nothing - symlink will be missing */
>>  
>>  	INIT_DELAYED_WORK(&devcd->del_wk, devcd_del);
>>  	schedule_delayed_work(&devcd->del_wk, DEVCD_TIMEOUT);
> 
> Could just remove the 'if's?
> 
> +	sysfs_create_link(&devcd->devcd_dev.kobj, &dev->kobj,
> +			"failing_device");
> 

OK.

thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
