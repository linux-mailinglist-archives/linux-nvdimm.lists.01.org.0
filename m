Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D576125BD66
	for <lists+linux-nvdimm@lfdr.de>; Thu,  3 Sep 2020 10:37:23 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B52ED13BE06E8;
	Thu,  3 Sep 2020 01:37:21 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=colyli@suse.de; receiver=<UNKNOWN> 
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 103A413BE06E6
	for <linux-nvdimm@lists.01.org>; Thu,  3 Sep 2020 01:37:17 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
	by mx2.suse.de (Postfix) with ESMTP id 82A99AFA8;
	Thu,  3 Sep 2020 08:37:17 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: Mike Snitzer <snitzer@redhat.com>
References: <20200902160432.GA5513@redhat.com>
 <df0203fa-7f75-53ac-8bf1-79a1c861918e@suse.de>
 <20200902164456.GA5928@redhat.com>
 <4968af50-663d-74cf-1be2-aaed48a380d5@suse.de>
 <20200902165101.GB5928@redhat.com>
 <c6636009-0bb9-ab2e-d453-992a2a53c6ef@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Subject: Re: flood of "dm-X: error: dax access failed" due to 5.9 commit
 231609785cbfb
Message-ID: <eac2bcb8-93c7-ae47-c9e3-43c1ac074098@suse.de>
Date: Thu, 3 Sep 2020 16:37:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <c6636009-0bb9-ab2e-d453-992a2a53c6ef@suse.de>
Content-Language: en-US
Message-ID-Hash: KT723QMGNCUEABPEHTZW5ANRZLM7TIKE
X-Message-ID-Hash: KT723QMGNCUEABPEHTZW5ANRZLM7TIKE
X-MailFrom: colyli@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, linux-nvdimm@lists.01.org, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/KT723QMGNCUEABPEHTZW5ANRZLM7TIKE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020/9/3 13:20, Coly Li wrote:
> On 2020/9/3 00:51, Mike Snitzer wrote:
>> On Wed, Sep 02 2020 at 12:46pm -0400,
>> Coly Li <colyli@suse.de> wrote:
>>
>>> On 2020/9/3 00:44, Mike Snitzer wrote:
>>>> On Wed, Sep 02 2020 at 12:40pm -0400,
>>>> Coly Li <colyli@suse.de> wrote:
>>>>
>>>>> On 2020/9/3 00:04, Mike Snitzer wrote:
>>>>>> 5.9 commit 231609785cbfb ("dax: print error message by pr_info() in
>>>>>> __generic_fsdax_supported()") switched from pr_debug() to pr_info().
>>>>>>
>>>>>> The justification in the commit header is really inadequate.  If there
>>>>>> is a problem that you need to drill in on, repeat the testing after
>>>>>> enabling the dynamic debugging.
>>>>>>
>>>>>> Otherwise, now all DM devices that aren't layered on DAX capable devices
>>>>>> spew really confusing noise to users when they simply activate their
>>>>>> non-DAX DM devices:
>>>>>>
>>>>>> [66567.129798] dm-6: error: dax access failed (-5)
>>>>>> [66567.134400] dm-6: error: dax access failed (-5)
>>>>>> [66567.139152] dm-6: error: dax access failed (-5)
>>>>>> [66567.314546] dm-2: error: dax access failed (-95)
>>>>>> [66567.319380] dm-2: error: dax access failed (-95)
>>>>>> [66567.324254] dm-2: error: dax access failed (-95)
>>>>>> [66567.479025] dm-2: error: dax access failed (-95)
>>>>>> [66567.483713] dm-2: error: dax access failed (-95)
>>>>>> [66567.488722] dm-2: error: dax access failed (-95)
>>>>>> [66567.494061] dm-2: error: dax access failed (-95)
>>>>>> [66567.498823] dm-2: error: dax access failed (-95)
>>>>>> [66567.503693] dm-2: error: dax access failed (-95)
>>>>>>
>>>>>> commit 231609785cbfb must be reverted.
>>>>>>
>>>>>> Please advise, thanks.
>>>>>
>>>>> Adrian Huang from Lenovo posted a patch, which titled: dax: do not print
>>>>> error message for non-persistent memory block device
>>>>>
>>>>> It fixes the issue, but no response for now. Maybe we should take this fix.
>>>>
>>>> OK, yes sounds like it.  It was merged and is commit c2affe920b0e066
>>>> ("dax: do not print error message for non-persistent memory block
>>>> device")
>>>
>>> Thanks for informing me this patch is merged, I am going to update my
>>> local one :-)
>>
>> So the thing is I'm running v5.9-rc3 (which includes this commit) but
>> I'm still seeing all these warnings when I run the lvm2 testsuite.  The
>> reason _seems_ to be because the lvm2 testsuite uses brd devices for
>> test devices.  So there is something about the brd device that shows
>> commit c2affe920b0e066 isn't enough :(
> 
> [Resend and CC Adrian Huang]
> 
> Hi Mike,
> 
> Could you please apply and test this attached patch based on v5.9-rc3 ?
> 
> It seems the pointer dax_dev of __generic_fsdax_supported() parameter is
> not initialized (IMHO this is not a dm bug), therefore the && should be
> || to check the dax support state.
> 
> Also I add two pr_info() to print the variables value, let's see whether
> my guess makes sense.

Also I suggest some kind of change like this in drivers/md/dm.c,

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index fb0255d25e4b..566d8208df47 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -818,6 +818,8 @@ int dm_get_table_device(struct mapped_device *md,
dev_t dev, fmode_t mode,
                        return -ENOMEM;
                }

+               memset(td, 0, sizeof(struct table_device));
+
                td->dm_dev.mode = mode;
                td->dm_dev.bdev = NULL;


The above change may make sure *dax_dev sent into
__generic_fsdax_supported() is always NULL if the target does not
support DAX. But IMHO this is not 100% necessary, it just make
__generic_fsdax_supported() return false faster by the following change
in previous attached patch,

 -       if (!dax_dev && !bdev_dax_supported(bdev, blocksize)) {
 +       if (!dax_dev || !bdev_dax_supported(bdev, blocksize)) {

I am not very familiar with dm code, CMIIW, just for your information.

Coly Li
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
