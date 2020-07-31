Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EF23422B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 31 Jul 2020 11:15:57 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B4EAB12878866;
	Fri, 31 Jul 2020 02:15:55 -0700 (PDT)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=183.91.158.132; helo=heian.cn.fujitsu.com; envelope-from=lihao2018.fnst@cn.fujitsu.com; receiver=<UNKNOWN> 
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
	by ml01.01.org (Postfix) with ESMTP id 20CC912878865
	for <linux-nvdimm@lists.01.org>; Fri, 31 Jul 2020 02:15:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.75,417,1589212800";
   d="scan'208";a="97213083"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 31 Jul 2020 17:15:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
	by cn.fujitsu.com (Postfix) with ESMTP id 04C184CE1505;
	Fri, 31 Jul 2020 17:15:46 +0800 (CST)
Received: from [10.167.225.206] (10.167.225.206) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 31 Jul 2020 17:15:47 +0800
Subject: Re: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
To: Dave Chinner <david@fromorbit.com>
References: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20200728022059.GX2005@dread.disaster.area>
 <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
 <20200729232131.GC2005@dread.disaster.area>
From: "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
Message-ID: <f590651d-db6d-74b0-f730-2db760bc1252@cn.fujitsu.com>
Date: Fri, 31 Jul 2020 17:15:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20200729232131.GC2005@dread.disaster.area>
Content-Language: en-US
X-Originating-IP: [10.167.225.206]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 04C184CE1505.ADEF3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lihao2018.fnst@cn.fujitsu.com
X-Spam-Status: No
Message-ID-Hash: D7T7IXYIDRK6YJRVA2PIE7EG3WK2I2IF
X-Message-ID-Hash: D7T7IXYIDRK6YJRVA2PIE7EG3WK2I2IF
X-MailFrom: lihao2018.fnst@cn.fujitsu.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, yangx.jy@cn.fujitsu.com, gujx@cn.fujitsu.com, Yasunori Goto <y-goto@fujitsu.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D7T7IXYIDRK6YJRVA2PIE7EG3WK2I2IF/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 2020/7/30 7:21, Dave Chinner wrote:

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
>>>   6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
>>>      the change in behaviour for existing regular files may not occur
>>>      immediately.  If the change must take effect immediately, the administrator
>>>      needs to:
>>>
>>>      a) stop the application so there are no active references to the data set
>>>         the policy change will affect
>>>
>>>      b) evict the data set from kernel caches so it will be re-instantiated when
>>>         the application is restarted. This can be achieved by:
>>>
>>>         i. drop-caches
>>>         ii. a filesystem unmount and mount cycle
>>>         iii. a system reboot
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
chattr command can be executed by normal users as long as they want.
I think if they do this, they may get confused because the dax mode
doesn't take effects immediately.
>> So, if kernel have a feature for normal user can operate drop cache for "a
>> inode" with
>> its permission, I think it improve the above limitation, and
>> we would like to try to implement it recently.
> No, drop_caches is not going to be made available to users. That
> makes it s trivial system wide DoS vector.
drop_caches have to be limited for root user, but we may need to find
a way for normal users to make dax changing take effect if they have
run chattr.

Regards,
Hao Li

> Cheers,
>
> Dave.

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
