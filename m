Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF01AF3B9
	for <lists+linux-nvdimm@lfdr.de>; Sat, 18 Apr 2020 20:50:05 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B202810FC62D6;
	Sat, 18 Apr 2020 11:50:11 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 606A010FC62D3
	for <linux-nvdimm@lists.01.org>; Sat, 18 Apr 2020 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Sender:Reply-To:Content-ID:Content-Description;
	bh=na4bJ3PkcifD0nFgc5n3XvGryFaz89gkoFznEG5QSiA=; b=s8O9bLPQ3/PwyhlXG8w8qqYbwq
	sTtpsGIripwqUAVAAsu2nj/XCKxMas3tSgjRxl3gHNtvArdEj1uffO6xT7tPA3EqF9wmB93jjToSn
	N4K9MdbnF1AhlTs/5V0mo2YU4ioGpwniS9b7RLbThV642vvH0Oaw4DQvAXombZAy6nkuiqaTG5ZtZ
	3ETZbMbDXUb4qlER1RXVuV+nxpkl9G+aWvUaDQqrcR0Iyoie1anJryeuc5zYhk4x+UQ4IP5g9eBoV
	vQvnY/lULm5KVOhnO0YdeCnzPEXXBNqZu/Zs1RAWjA3aKwPFfzK/pLRb/7u0sH8oOF7NyLx+KXYAJ
	bRYCu/FA==;
Received: from [2601:1c0:6280:3f0::19c2]
	by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jPsXQ-0003BB-Ls; Sat, 18 Apr 2020 18:50:00 +0000
Subject: Re: [RFC PATCH 1/9] kernel.h: add do_empty() macro
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
References: <20200418184111.13401-1-rdunlap@infradead.org>
 <20200418184111.13401-2-rdunlap@infradead.org>
 <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3990866b-3331-560d-e5e3-6b51ae51c1e2@infradead.org>
Date: Sat, 18 Apr 2020 11:49:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6bb8d99e6e56fa1622fc7238c1ae37c3b3510ded.camel@perches.com>
Content-Language: en-US
Message-ID-Hash: DGWMNFQ3C3X6WT3U7J7S46PHJ7OW2SJX
X-Message-ID-Hash: DGWMNFQ3C3X6WT3U7J7S46PHJ7OW2SJX
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>, Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, linux-nvdimm@lists.01.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Zzy Wysm <zzy@zzywysm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/DGWMNFQ3C3X6WT3U7J7S46PHJ7OW2SJX/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 4/18/20 11:44 AM, Joe Perches wrote:
> On Sat, 2020-04-18 at 11:41 -0700, Randy Dunlap wrote:
>> Add the do_empty() macro to silence gcc warnings about an empty body
>> following an "if" statement when -Wextra is used.
>>
>> However, for debug printk calls that are being disabled, use either
>> no_printk() or pr_debug() [and optionally dynamic printk debugging]
>> instead.
> []
>> +#define do_empty()		do { } while (0)
> 
> If this is really useful
> (I think the warning is somewhat silly)
> 
> bikeshed:
> 
> I think do_nothing() is more descriptive

Yes, I do too, as I more or less mentioned in the cover letter.

-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
