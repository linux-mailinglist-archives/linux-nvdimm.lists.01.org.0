Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DFD22FB96
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 23:44:54 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 05FC7123D91FA;
	Mon, 27 Jul 2020 14:44:52 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=jack@suse.cz; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BA3B0123D91D7
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 14:44:49 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id F2018AC97;
	Mon, 27 Jul 2020 21:44:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
	id 471021E12C7; Mon, 27 Jul 2020 23:44:47 +0200 (CEST)
Date: Mon, 27 Jul 2020 23:44:47 +0200
From: Jan Kara <jack@suse.cz>
To: Jane Chu <jane.chu@oracle.com>
Subject: Re: [PATCH v3] dax: print error message by pr_info() in
 __generic_fsdax_supported()
Message-ID: <20200727214447.GN5284@quack2.suse.cz>
References: <20200725162450.95999-1-colyli@suse.de>
 <7366fc46-48ee-8c9a-c8f2-8e4e03919880@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7366fc46-48ee-8c9a-c8f2-8e4e03919880@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: N5K4AXVXNTV4D34NJNYMNRHXK7I2C7NN
X-Message-ID-Hash: N5K4AXVXNTV4D34NJNYMNRHXK7I2C7NN
X-MailFrom: jack@suse.cz
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Coly Li <colyli@suse.de>, linux-nvdimm@lists.01.org, msuchanek@suse.com, ailiopoulos@suse.com, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/N5K4AXVXNTV4D34NJNYMNRHXK7I2C7NN/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon 27-07-20 10:02:11, Jane Chu wrote:
> Hi,
> 
> On 7/25/2020 9:24 AM, Coly Li wrote:
> > It is not simple to make dax_supported() from struct dax_operations
> > or __generic_fsdax_supported() to return exact failure type right now.
> > So the simplest fix is to use pr_info() to print all the error messages
> > inside __generic_fsdax_supported(). Then users may find informative clue
> > from the kernel message at least.
> 
> I happen to notice that some servers set their printk levels at 4 by default
> to minimize console messages:
> # cat /proc/sys/kernel/printk
>  4   4   1  7
> So I'm wondering if you would consider pr_error() instead of pr_info() ?

I don't think this is a good reason to raise priority of this message -
with this logic applied, all info messages should be raised to error level
because someone may find them useful :). And then people raise printk
loglevel because the kernel is too noisy... Personally I think that
pr_info() is fine because there will be error message about unsupported dax
setup from the filesystem and if sysadmin wishes, (s)he can always lookup
info messages in dmesg.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
