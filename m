Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A682DF4DF
	for <lists+linux-nvdimm@lfdr.de>; Sun, 20 Dec 2020 10:46:25 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5D0DB100ED4AF;
	Sun, 20 Dec 2020 01:46:23 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F08EA100EF261
	for <linux-nvdimm@lists.01.org>; Sun, 20 Dec 2020 01:46:20 -0800 (PST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id B8CDCAC7B;
	Sun, 20 Dec 2020 09:46:18 +0000 (UTC)
To: antlists <antlists@youngman.org.uk>, axboe@kernel.dk,
 dan.j.williams@intel.com, vishal.l.verma@intel.com
References: <20201203171535.67715-1-colyli@suse.de>
 <3f4bf4c4-1f1f-b1a6-5d91-2dbe02f61e67@youngman.org.uk>
From: Coly Li <colyli@suse.de>
Subject: Re: [RFC PATCH] badblocks: Improvement badblocks_set() for handling
 multiple ranges
Message-ID: <c50e7c65-d7bf-e957-d8eb-efed6c24f089@suse.de>
Date: Sun, 20 Dec 2020 17:46:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <3f4bf4c4-1f1f-b1a6-5d91-2dbe02f61e67@youngman.org.uk>
Content-Language: en-US
Message-ID-Hash: UL3EZWEXEPYF2Z4C437SSDIROWXWFJFK
X-Message-ID-Hash: UL3EZWEXEPYF2Z4C437SSDIROWXWFJFK
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/UL3EZWEXEPYF2Z4C437SSDIROWXWFJFK/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 12/20/20 4:02 AM, antlists wrote:
> On 03/12/2020 17:15, Coly Li wrote:
>> This patch is an initial effort to improve badblocks_set() for setting
>> bad blocks range when it covers multiple already set bad ranges in the
>> bad blocks table, and to do it as fast as possible.
> 
> Is this your patch, or submitted as part of the bug report?

This is not finished yet. The final version should go into upstream as a
fix for current badblocks routines.

> 
> "Heavily based on MD badblocks code from Neil Brown"
> 
> How much has this code got to do with the mdraid subsystem? Because
> badblocks in mdraid has an appalling reputation, with many people
> wanting to just rip it out.

This is in-memory data structure management which is almost irrelevant
to md raid or other on-disk layout.


> 
> If this code is separate from the mdraid implementation, any chance you
> can work with it, and fix that at the same time? Or make it redundant! I

This is 100% separated from md raid, as well as current badblocks code,
it is just about combine or split some [start, length] extent in a
table. The purpose of this patch is to fixing some reported issue from
users and our customers.

> don't quite see why mdraid should need a badblocks list given modern
> disk drives.
> 

For me the motivation is just people report bugs and I fix it. If there
is new code to replace it in upstream, then I just continue to maintain
the new code for our users and customers.

> And it's on my to-do list (if I can find the time!!!) to integrate
> dm-integrity into mdraid, at which point md badblocks should be irrelevant.
> 
> Hope I'm not being a shower of cold water, and if you want to fix all
> this, good on you, but to the extent that this is relevant to
> linux-raid, I think a lot of people will be asking "What's the point?"

Currently blocks/badblocks.c is used by md raid and nvdimm code, and the
badblocks table is irrelevant to any of these two subsystems.

If there will be better code for similar or better functionality, it
should be cool. For me, if the reporting bug is fixed, no difference in
my view :-)

Thanks.

Coly Li
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
