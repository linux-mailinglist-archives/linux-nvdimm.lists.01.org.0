Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AD32FE4B5
	for <lists+linux-nvdimm@lfdr.de>; Thu, 21 Jan 2021 09:15:53 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 35A04100EB348;
	Thu, 21 Jan 2021 00:15:51 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 372A1100ED4BA
	for <linux-nvdimm@lists.01.org>; Thu, 21 Jan 2021 00:15:49 -0800 (PST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0EA932395B;
	Thu, 21 Jan 2021 08:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1611216948;
	bh=jlGXwu1tfbij7TJcmlF5/XEfn/3LQg2wD0tO1MQn1WE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rgOWqcHpKKCiOpXET9VzHjKBIXwWiW2ZUWA+oV/ir8LnBLyEjWZzWCxPQow8wKKan
	 CsYu2KuRioZXH9e2rDzBeY3BTOoFyIhgoTrUUmxGBmvsMMPwAAopQEg6ro8g6R2Zwu
	 FIFwsPrENE3I8GA+JQNG1xu+K47RJUOo/Wni4tZk=
Date: Thu, 21 Jan 2021 09:15:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/3] libnvdimm/ioctl: Switch to cdev_register_queued()
Message-ID: <YAk4MMMmmbKe6XEQ@kroah.com>
References: <161117153248.2853729.2452425259045172318.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <161117154856.2853729.1012816981381380656.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID-Hash: VS6USED2UO2REWULJHJLTHUBIIZ2SLLG
X-Message-ID-Hash: VS6USED2UO2REWULJHJLTHUBIIZ2SLLG
X-MailFrom: gregkh@linuxfoundation.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: logang@deltatee.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VS6USED2UO2REWULJHJLTHUBIIZ2SLLG/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Wed, Jan 20, 2021 at 11:39:08AM -0800, Dan Williams wrote:
> The ioctl implementation in libnvdimm is a case study in what can be
> cleaned up when the cdev core handles synchronizing in-flight ioctls
> with device removal. Switch to cdev_register_queued() which allows for
> the ugly context lookup and activity tracking implementation to be
> dropped, among other cleanups.

I'm confused, the cdev handles the filesystem access from /dev/ which
handles the ioctl.  Any use of a cdev with relationship to a struct
device that might go away is independent, so we really should not tie
these together in any way.

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
