Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33702481B5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Aug 2020 11:16:50 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B2F551300A5C0;
	Tue, 18 Aug 2020 02:16:47 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=lihao2018.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 49F1E1300A5BD
	for <linux-nvdimm@lists.01.org>; Tue, 18 Aug 2020 02:16:44 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.76,326,1592841600";
   d="scan'208";a="98221465"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 18 Aug 2020 17:16:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id DE4424CE38A1;
	Tue, 18 Aug 2020 17:16:41 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 18 Aug 2020 17:16:41 +0800
Subject: Re: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
To: Ira Weiny <ira.weiny@intel.com>, Yasunori Goto <y-goto@fujitsu.com>
References: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20200728022059.GX2005@dread.disaster.area>
 <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
 <20200729232131.GC2005@dread.disaster.area>
 <0d380010-cccd-162d-32bc-07d094cb152d@fujitsu.com>
 <20200807170858.GU1573827@iweiny-DESK2.sc.intel.com>
From: "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <ba98b77e-a806-048a-a0dc-ca585677daf3@cn.fujitsu.com>
Date: Tue, 18 Aug 2020 17:16:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20200807170858.GU1573827@iweiny-DESK2.sc.intel.com>
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: DE4424CE38A1.ACD23
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: 5CU6NQDNYECGSPFHJ6JDLNPUZTD2J4MB
X-Message-ID-Hash: 5CU6NQDNYECGSPFHJ6JDLNPUZTD2J4MB
X-MailFrom: lihao2018.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Dave Chinner <david@fromorbit.com>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5CU6NQDNYECGSPFHJ6JDLNPUZTD2J4MB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On 2020/8/8 1:09, Ira Weiny wrote:
> On Fri, Jul 31, 2020 at 06:59:32PM +0900, Yasunori Goto wrote:
>> On 2020/07/30 8:21, Dave Chinner wrote:
>>> On Wed, Jul 29, 2020 at 11:23:21AM +0900, Yasunori Goto wrote:
>>>> Hi,
>>>>
>>>> On 2020/07/28 11:20, Dave Chinner wrote:
>>>>> On Tue, Jul 28, 2020 at 02:00:08AM +0000, Li, Hao wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I have noticed that we have to drop caches to make the changing of S_DAX
>>>>>> flag take effect after using chattr +x to turn on DAX for a existing
>>>>>> regular file. The related function is xfs_diflags_to_iflags, whose
>>>>>> second parameter determines whether we should set S_DAX immediately.
>>>>> Yup, as documented in Documentation/filesystems/dax.txt. Specifically:
>>>>>
>>>>>    6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
>>>>>       the change in behaviour for existing regular files may not occur
>>>>>       immediately.  If the change must take effect immediately, the administrator
>>>>>       needs to:
>>>>>
>>>>>       a) stop the application so there are no active references to the data set
>>>>>          the policy change will affect
>>>>>
>>>>>       b) evict the data set from kernel caches so it will be re-instantiated when
>>>>>          the application is restarted. This can be achieved by:
>>>>>
>>>>>          i. drop-caches
>>>>>          ii. a filesystem unmount and mount cycle
>>>>>          iii. a system reboot
>>>>>
>>>>>> I can't figure out why we do this. Is this because the page caches in
>>>>>> address_space->i_pages are hard to deal with?
>>>>> Because of unfixable races in the page fault path that prevent
>>>>> changing the caching behaviour of the inode while concurrent access
>>>>> is possible. The only way to guarantee races can't happen is to
>>>>> cycle the inode out of cache.
>>>> I understand why the drop_cache operation is necessary. Thanks.
>>>>
>>>> BTW, even normal user becomes to able to change DAX flag for an inode,
>>>> drop_cache operation still requires root permission, right?
>>> Step back for a minute and explain why you want to be able to change
>>> the DAX mode of a file -as a user-.
>>
>> For example, there are 2 containers executed in a system, which is named as
>> container A and container B, and these host gives FS-DAX files to each
>> containers.
>> If the user of container A would like to change DAX-off for tuning, then he
>> will stop his application
>> and change DAX flag, but the flag may not be changed.
>>
>> Then he will "need" to ask host operator to execute drop_cache, and the
>> operator did it.
>> As a result, not only container A, but also container B get the impact of
>> drop_cache.
>>
>> Especially, if this is multi tenant container system, then I think this is
>> not acceptable.
>>
>> Probably, there are 2 problems I think.
>> 1) drop_cache requires root permission.
>> 2) drop_cache has too wide effect.
>>
>>>> So, if kernel have a feature for normal user can operate drop cache for "a
>>>> inode" with
>>>> its permission, I think it improve the above limitation, and
>>>> we would like to try to implement it recently.
>>> No, drop_caches is not going to be made available to users. That
>>> makes it s trivial system wide DoS vector.
>> The current drop_cache feature tries to drop ALL of cache (page cache and/or
>> slab cache).
>> Then, I agree that normal user should not drop all of them.
>>
>> But my intention was that drop cache of ONE file which is changed dax flag,
>> (and if possible, drop only the inode cache.)
>> Do you mean it will be still cause of weakness against DoS attack?
>> If so, I should give up to solve problem 1) at least.
> FWIW changing the on disk flag automatically flags the inode to be dropped as
> soon as all references are done.
>
> See:
>
> 2c567af418e3 fs: Introduce DCACHE_DONTCACHE
> dae2f8ed7992 fs: Lift XFS_IDONTCACHE to the VFS layer
Hi,

I find that DCACHE_DONTCACHE doesn't work well.
If DCACHE_REFERENCED is not set, dput() can drop the inode successfully as
soon as all references are gone. By contrast, if DCACHE_REFERENCED is set,
dput() only decreases the reference count of dentry and don't evict inode.

Example 1:

echo abcdefg > test.txt
echo 3 > /proc/sys/vm/drop_caches
xfs_io -c 'chattr +x' test.txt

In this example, we can say the DAX policy takes effects immediately as we
don't need to drop cache after chattr.
In this circumstance, DCACHE_REFERENCED is not set, and DCACHE_DONTCACHE
can drop the inode as expected.

Example 2:

echo abcdefg > test.txt
xfs_io -c 'chattr +x' test.txt

In this example, we must drop caches after chattr to make DAX policy
take effects. This is because DCACHE_REFERENCED is set, and fast_dput() will
return true, and then retain_dentry() have no chance to check DCACHE_DONTCACHE.

If this is the desired behavior, I can't understand the necessity
of DCACHE_DONTCACHE.

Regards,
Hao Li
>
> But from a users perspective you just don't know when that will happen.  The
> system just can't guarantee it.  The best the user can do is stop taking
> references to the file and close all references, and periodically check the
> state.  But this will take a reference so...  Kind of a catch-22 here...  :-(
>
> Ira
>
>>
>> Thanks,
>>
>>> Cheers,
>>>
>>> Dave.
>> -- 
>> Yasunori Goto
>>
>

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
