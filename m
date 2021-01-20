Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8B2FDA0B
	for <lists+linux-nvdimm@lfdr.de>; Wed, 20 Jan 2021 20:50:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5692D100EB32E;
	Wed, 20 Jan 2021 11:50:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=204.191.154.188; helo=ale.deltatee.com; envelope-from=logang@deltatee.com; receiver=<UNKNOWN> 
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 4F830100EB84B
	for <linux-nvdimm@lists.01.org>; Wed, 20 Jan 2021 11:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:content-disposition;
	bh=FpuctqQYr7HiImXDtxO/Xmx4gM6wv9pGDhDLLlURPOs=; b=YDfes3u6g94InF+L7Eb1SDp49B
	ABL/A4XSKrcHSzyKASffzB6ePsnECaDDQkvIXypGmmkXftC2h9QOeEPd42wGc3VIBWG55Zgz2v5Df
	92MzwVRCGqnIYMMyfsb8l5DbMmpQSN0X1kl8GYC6Bd5L0IqmrfYz87adODZr6Wp+Il8JjCbq2Be2A
	ypbRzyHyYlvm5HZSFt63QRRO/vONle105KzlgMr4uFBap7rhEYZTJTxfP/UmufThWd3xw0vGuUAdQ
	CRFeQVWe9gdVx+CPwXnmJMIZ+wClHsD0b2DKd1ZndyJKZ53Byq9DQduJ97FWphbVtrWP8/Ni3lL+p
	h2pFyAfQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <logang@deltatee.com>)
	id 1l2JV8-00022C-Hh; Wed, 20 Jan 2021 12:50:47 -0700
To: Dan Williams <dan.j.williams@intel.com>, gregkh@linuxfoundation.org
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <809823fb-6eb6-8ce9-c49a-d85b03897fc7@deltatee.com>
Date: Wed, 20 Jan 2021 12:50:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <161117153776.2853729.6944617921517514510.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com, dave.jiang@intel.com, viro@zeniv.linux.org.uk, alexandre.belloni@free-electrons.com, hans.verkuil@cisco.com, gregkh@linuxfoundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
	version=3.4.2
Subject: Re: [PATCH 1/3] cdev: Finish the cdev api with queued mode support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Message-ID-Hash: NJOIXZBZBEZPSOB52GT3Y2WPHRIQAPQQ
X-Message-ID-Hash: NJOIXZBZBEZPSOB52GT3Y2WPHRIQAPQQ
X-MailFrom: logang@deltatee.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Hans Verkuil <hans.verkuil@cisco.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NJOIXZBZBEZPSOB52GT3Y2WPHRIQAPQQ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit




On 2021-01-20 12:38 p.m., Dan Williams wrote:
> ...common reference count handling scenarios were addressed, but the
> shutdown-synchronization problem was only mentioned as something driver
> developers need to be aware in the following note:
> 
>     NOTE: This guarantees that associated sysfs callbacks are not running
>     or runnable, however any cdevs already open will remain and their fops
>     will still be callable even after this function returns.
> 
> Remove that responsibility from driver developers with the concept of a
> 'queued' mode for cdevs.

I find the queued name confusing. What's being queued?

> +static const struct file_operations cdev_queued_fops = {
> +	.owner = THIS_MODULE,
> +	.open = cdev_queued_open,
> +	.unlocked_ioctl = cdev_queued_ioctl,
> +	.compat_ioctl = compat_ptr_ioctl,
> +	.llseek = noop_llseek,
> +};

Why do we only protect these fops? I'd find it a bit confusing to have
ioctl protected from use after del, but not write/read/etc.

Logan
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
