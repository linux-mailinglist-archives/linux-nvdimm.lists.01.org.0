Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3EF2343D0
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 11:59:45 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 0E9E9128B87DB;
	Fri, 31 Jul 2020 02:59:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.128.242.43; helo=mgwym04.jp.fujitsu.com; envelope-from=y-goto@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwym04.jp.fujitsu.com (mgwym04.jp.fujitsu.com [211.128.242.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 59F89128B87D7
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 02:59:38 -0700 (PDT)
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym04.jp.fujitsu.com with smtp
	 id 7d9c_6de8_d612993c_3152_43be_9f61_2b02de50282a;
	Fri, 31 Jul 2020 18:59:32 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 3EC1CAC00FB
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 18:59:32 +0900 (JST)
Received: from [10.133.116.206] (VPC-Y08P0560552.g01.fujitsu.local [10.133.116.206])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id 32B7A3D2;
	Fri, 31 Jul 2020 18:59:32 +0900 (JST)
Subject: Re: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
To: Dave Chinner <david@fromorbit.com>
References: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20200728022059.GX2005@dread.disaster.area>
 <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
 <20200729232131.GC2005@dread.disaster.area>
From: Yasunori Goto <y-goto@fujitsu.com>
Message-ID: <0d380010-cccd-162d-32bc-07d094cb152d@fujitsu.com>
Date: Fri, 31 Jul 2020 18:59:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200729232131.GC2005@dread.disaster.area>
Content-Language: en-US
X-TM-AS-GCONF: 00
Message-ID-Hash: RF3OP33LLGCJ2FQIQ2HUV7SJNHKZM7VZ
X-Message-ID-Hash: RF3OP33LLGCJ2FQIQ2HUV7SJNHKZM7VZ
X-MailFrom: y-goto@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/RF3OP33LLGCJ2FQIQ2HUV7SJNHKZM7VZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 2020/07/30 8:21, Dave Chinner wrote:
> On Wed, Jul 29, 2020 at 11:23:21AM +0900, Yasunori Goto wrote:
>> Hi,
>>
>> On 2020/07/28 11:20, Dave Chinner wrote:
>>> On Tue, Jul 28, 2020 at 02:00:08AM +0000, Li, Hao wrote:
>>>> Hi,
>>>>
>>>> I have noticed that we have to drop caches to make the changing of S_DAX
>>>> flag take effect after using chattr +x to turn on DAX for a existing
>>>> regular file. The related function is xfs_diflags_to_iflags, whose
>>>> second parameter determines whether we should set S_DAX immediately.
>>> Yup, as documented in Documentation/filesystems/dax.txt. Specifically:
>>>
>>>    6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
>>>       the change in behaviour for existing regular files may not occur
>>>       immediately.  If the change must take effect immediately, the administrator
>>>       needs to:
>>>
>>>       a) stop the application so there are no active references to the data set
>>>          the policy change will affect
>>>
>>>       b) evict the data set from kernel caches so it will be re-instantiated when
>>>          the application is restarted. This can be achieved by:
>>>
>>>          i. drop-caches
>>>          ii. a filesystem unmount and mount cycle
>>>          iii. a system reboot
>>>
>>>> I can't figure out why we do this. Is this because the page caches in
>>>> address_space->i_pages are hard to deal with?
>>> Because of unfixable races in the page fault path that prevent
>>> changing the caching behaviour of the inode while concurrent access
>>> is possible. The only way to guarantee races can't happen is to
>>> cycle the inode out of cache.
>> I understand why the drop_cache operation is necessary. Thanks.
>>
>> BTW, even normal user becomes to able to change DAX flag for an inode,
>> drop_cache operation still requires root permission, right?
> Step back for a minute and explain why you want to be able to change
> the DAX mode of a file -as a user-.


For example, there are 2 containers executed in a system, which is named as
container A and container B, and these host gives FS-DAX files to each 
containers.
If the user of container A would like to change DAX-off for tuning, then 
he will stop his application
and change DAX flag, but the flag may not be changed.

Then he will "need" to ask host operator to execute drop_cache, and the 
operator did it.
As a result, not only container A, but also container B get the impact 
of drop_cache.

Especially, if this is multi tenant container system, then I think this 
is not acceptable.

Probably, there are 2 problems I think.
1) drop_cache requires root permission.
2) drop_cache has too wide effect.

>
>> So, if kernel have a feature for normal user can operate drop cache for "a
>> inode" with
>> its permission, I think it improve the above limitation, and
>> we would like to try to implement it recently.
> No, drop_caches is not going to be made available to users. That
> makes it s trivial system wide DoS vector.

The current drop_cache feature tries to drop ALL of cache (page cache 
and/or slab cache).
Then, I agree that normal user should not drop all of them.

But my intention was that drop cache of ONE file which is changed dax flag,
(and if possible, drop only the inode cache.)
Do you mean it will be still cause of weakness against DoS attack?
If so, I should give up to solve problem 1) at least.


Thanks,

>
> Cheers,
>
> Dave.

-- 
Yasunori Goto
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
