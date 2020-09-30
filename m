Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E140227DD46
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Sep 2020 02:13:40 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3420D152E6714;
	Tue, 29 Sep 2020 17:13:39 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=rdunlap@infradead.org; receiver=<UNKNOWN> 
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 7F9A9150C6C09
	for <linux-nvdimm@lists.01.org>; Tue, 29 Sep 2020 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=TahisG6kUDutXipbSb0V03+wLD+q13trx54ypaJdagw=; b=HKVw5IB0hKYct1Uuw5lklIVCpV
	xIZbt6VpLzXCuKp7AVdtX3indQiObrAjXZK2OA8P24B1NiVEZW/A/CW8G4xmiCSFCIEycEXrpEouN
	GS+AB1Cvtoj7VsWfmOjT+KRdFl+s3HxVZIg3Ny93a9/ZezVvUVePIQz6ShtlqxRWhw9HdQHTCxaHC
	WnUrWMAuzc91jJ+MwsUgE48yut+uFo9chQM+Kt4w8H4qaQaPyWn1RHEoamyd/j3qtSaqgvukDYnr1
	vZDU2UeFKGWnuXF3hFi3G7/P6Bxhpyj558Ww/GKzSFZ1GQUuoh+irzDyWYnFTf5XArKfOGcgvQ0nF
	KKG3rqIw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
	by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNPkS-0000MO-Un; Wed, 30 Sep 2020 00:13:33 +0000
Subject: Re: [PATCH 17/22] mpool: add mpool lifecycle management ioctls
To: nmeeramohide@micron.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mm@kvack.org, linux-nvdimm@lists.01.org
References: <20200928164534.48203-1-nmeeramohide@micron.com>
 <20200928164534.48203-18-nmeeramohide@micron.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <43f24e68-2625-36ce-1727-fcf981955b17@infradead.org>
Date: Tue, 29 Sep 2020 17:13:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928164534.48203-18-nmeeramohide@micron.com>
Content-Language: en-US
Message-ID-Hash: U4AMWG6JVPXR6BOL6LIV4YVGCFQ3BOLM
X-Message-ID-Hash: U4AMWG6JVPXR6BOL6LIV4YVGCFQ3BOLM
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: smoyer@micron.com, gbecker@micron.com, plabat@micron.com, jgroves@micron.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/U4AMWG6JVPXR6BOL6LIV4YVGCFQ3BOLM/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 9/28/20 9:45 AM, nmeeramohide@micron.com wrote:
> +	if (_IOC_TYPE(cmd) != MPIOC_MAGIC)
Hi,

MPIOC_MAGIC is defined in patch 01/22.
It should also be added to Documentation/userspace-api/ioctl/ioctl-number.rst.


thanks.
-- 
~Randy
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
