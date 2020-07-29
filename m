Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D98231798
	for <lists+linux-nvdimm@lfdr.de>; Wed, 29 Jul 2020 04:23:34 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 83E9E1268E0C6;
	Tue, 28 Jul 2020 19:23:32 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=211.128.242.40; helo=mgwym01.jp.fujitsu.com; envelope-from=y-goto@fujitsu.com; receiver=<UNKNOWN> 
Received: from mgwym01.jp.fujitsu.com (mgwym01.jp.fujitsu.com [211.128.242.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69A1E1268E0C3
	for <linux-nvdimm@lists.01.org>; Tue, 28 Jul 2020 19:23:29 -0700 (PDT)
Received: from yt-mxoi1.gw.nic.fujitsu.com (unknown [192.168.229.67]) by mgwym01.jp.fujitsu.com with smtp
	 id 07f1_1f58_27e18af3_caca_4024_aad9_288cefbc803a;
	Wed, 29 Jul 2020 11:23:22 +0900
Received: from m3051.s.css.fujitsu.com (m3051.s.css.fujitsu.com [10.134.21.209])
	by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id AD7BCAC0100
	for <linux-nvdimm@lists.01.org>; Wed, 29 Jul 2020 11:23:21 +0900 (JST)
Received: from [10.133.122.138] (VPC-Y08P0560358.g01.fujitsu.local [10.133.122.138])
	by m3051.s.css.fujitsu.com (Postfix) with ESMTP id A19C7320;
	Wed, 29 Jul 2020 11:23:21 +0900 (JST)
Subject: Re: Can we change the S_DAX flag immediately on XFS without dropping
 caches?
To: Dave Chinner <david@fromorbit.com>,
 "Li, Hao" <lihao2018.fnst@cn.fujitsu.com>
References: <9dc179147f6a47279d801445f3efeecc@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20200728022059.GX2005@dread.disaster.area>
From: Yasunori Goto <y-goto@fujitsu.com>
Message-ID: <573feb69-bc38-8eb4-ee9b-7c49802eb737@fujitsu.com>
Date: Wed, 29 Jul 2020 11:23:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200728022059.GX2005@dread.disaster.area>
Content-Language: en-US
X-TM-AS-GCONF: 00
Message-ID-Hash: MSFJDYMZTV5WCKJC2DI72MDYAZ7UBG3D
X-Message-ID-Hash: MSFJDYMZTV5WCKJC2DI72MDYAZ7UBG3D
X-MailFrom: y-goto@fujitsu.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MSFJDYMZTV5WCKJC2DI72MDYAZ7UBG3D/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi,

On 2020/07/28 11:20, Dave Chinner wrote:
> On Tue, Jul 28, 2020 at 02:00:08AM +0000, Li, Hao wrote:
>> Hi,
>>
>> I have noticed that we have to drop caches to make the changing of S_DAX
>> flag take effect after using chattr +x to turn on DAX for a existing
>> regular file. The related function is xfs_diflags_to_iflags, whose
>> second parameter determines whether we should set S_DAX immediately.
> Yup, as documented in Documentation/filesystems/dax.txt. Specifically:
>
>   6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
>      the change in behaviour for existing regular files may not occur
>      immediately.  If the change must take effect immediately, the administrator
>      needs to:
>
>      a) stop the application so there are no active references to the data set
>         the policy change will affect
>
>      b) evict the data set from kernel caches so it will be re-instantiated when
>         the application is restarted. This can be achieved by:
>
>         i. drop-caches
>         ii. a filesystem unmount and mount cycle
>         iii. a system reboot
>
>> I can't figure out why we do this. Is this because the page caches in
>> address_space->i_pages are hard to deal with?
> Because of unfixable races in the page fault path that prevent
> changing the caching behaviour of the inode while concurrent access
> is possible. The only way to guarantee races can't happen is to
> cycle the inode out of cache.

I understand why the drop_cache operation is necessary. Thanks.

BTW, even normal user becomes to able to change DAX flag for an inode,
drop_cache operation still requires root permission, right?

So, if kernel have a feature for normal user can operate drop cache for 
"a inode" with
its permission, I think it improve the above limitation, and
we would like to try to implement it recently.

Do you have any opinion making such feature?
(Agree/opposition, or any other comment?)

Thanks,

-- 
Yasunori Goto
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
