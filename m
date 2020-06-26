Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 401F820ABAE
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jun 2020 07:06:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 78D1311022323;
	Thu, 25 Jun 2020 22:06:16 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 2857B11022298
	for <linux-nvdimm@lists.01.org>; Thu, 25 Jun 2020 22:06:14 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id 572142075D;
	Fri, 26 Jun 2020 05:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593147973;
	bh=ZMf6Y207fla0Q6Zs7PGkOq/9k07e+L0F39srL0AgIF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jC08JkK3MKWfBCAaVtu1R5tBvFuRxgExDn8OK2otXcHyn9AAKyIvy7ttNaKURx6gS
	 zccr5HqZZst9TRU6W8i0YDF2v0BPo9PrZjTxb8IoK6F0kFCMBffHtK4m1Dq0kvj8PL
	 K1ZAgCVo01AB9hW8yAI78z3M8JmEANeosrz+9/jU=
Date: Fri, 26 Jun 2020 07:06:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 08/12] driver-core: Introduce DEVICE_ATTR_ADMIN_{RO,RW}
Message-ID: <20200626050611.GA223424@kroah.com>
References: <159312902033.1850128.1712559453279208264.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159312906372.1850128.11611897078988158727.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <159312906372.1850128.11611897078988158727.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: NABWI35FUO22ONCOMPJCUFZTOMT7BIH5
X-Message-ID-Hash: NABWI35FUO22ONCOMPJCUFZTOMT7BIH5
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/NABWI35FUO22ONCOMPJCUFZTOMT7BIH5/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Jun 25, 2020 at 04:51:03PM -0700, Dan Williams wrote:
> A common pattern for using plain DEVICE_ATTR() instead of
> DEVICE_ATTR_RO() and DEVICE_ATTR_RW() is for attributes that want to
> limit read to only root.  I.e. many users of DEVICE_ATTR() are
> specifying 0400 or 0600 for permissions.
> 
> Given the expectation that CAP_SYS_ADMIN is needed to access these
> sensitive attributes and an explicit helper with the _ADMIN_ identifier
> for DEVICE_ATTR_ADMIN_{RO,RW}.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/device.h |    4 ++++
>  include/linux/sysfs.h  |    7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 15460a5ac024..d7c2570368fa 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -128,8 +128,12 @@ ssize_t device_store_bool(struct device *dev, struct device_attribute *attr,
>  		__ATTR_PREALLOC(_name, _mode, _show, _store)
>  #define DEVICE_ATTR_RW(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_RW(_name)
> +#define DEVICE_ATTR_ADMIN_RW(_name) \
> +	struct device_attribute dev_attr_##_name = __ATTR_RW_MODE(_name, 0600)
>  #define DEVICE_ATTR_RO(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_RO(_name)
> +#define DEVICE_ATTR_ADMIN_RO(_name) \
> +	struct device_attribute dev_attr_##_name = __ATTR_RO_MODE(_name, 0400)
>  #define DEVICE_ATTR_WO(_name) \
>  	struct device_attribute dev_attr_##_name = __ATTR_WO(_name)
>  #define DEVICE_ULONG_ATTR(_name, _mode, _var) \
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 86067dbe7745..34e84122f635 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -123,6 +123,13 @@ struct attribute_group {
>  	.show	= _name##_show,						\
>  }
>  
> +#define __ATTR_RW_MODE(_name, _mode) {					\
> +	.attr	= { .name = __stringify(_name),				\
> +		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> +	.show	= _name##_show,						\
> +	.store	= _name##_store,					\
> +}
> +
>  #define __ATTR_WO(_name) {						\
>  	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
>  	.store	= _name##_store,					\
> 

Nice!  Want me to take this now, I know of many other places that could
be cleaned up to use this (like the raw device bug that I just fixed...)

If not:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
