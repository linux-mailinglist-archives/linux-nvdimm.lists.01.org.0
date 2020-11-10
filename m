Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFD2AD43B
	for <lists+linux-nvdimm@lfdr.de>; Tue, 10 Nov 2020 11:59:11 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 462A4167D51BD;
	Tue, 10 Nov 2020 02:59:10 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=liuzhiqiang26@huawei.com; receiver=<UNKNOWN> 
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id CC9F8167D51BC
	for <linux-nvdimm@lists.01.org>; Tue, 10 Nov 2020 02:59:07 -0800 (PST)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CVlGm2l5Qz15Q92;
	Tue, 10 Nov 2020 18:58:56 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 10 Nov 2020
 18:58:55 +0800
Subject: Re: [ndctl PATCH 0/8] fix serverl issues reported by Coverity
To: <vishal.l.verma@intel.com>, <dan.j.williams@intel.com>
References: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <2f1597f4-6f2f-6224-e1d5-d3417c643e5c@huawei.com>
Date: Tue, 10 Nov 2020 18:58:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <bed3b3b3-1f30-6751-c0bf-15ecf70192f9@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.174.176.238]
X-CFilter-Loop: Reflected
Message-ID-Hash: J2WZ2ZFWZOMF44IWGI34UHL7Q6YVPKQR
X-Message-ID-Hash: J2WZ2ZFWZOMF44IWGI34UHL7Q6YVPKQR
X-MailFrom: liuzhiqiang26@huawei.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org, linfeilong <linfeilong@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/J2WZ2ZFWZOMF44IWGI34UHL7Q6YVPKQR/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

friendly ping...

On 2020/11/6 17:23, Zhiqiang Liu wrote:
> 
> Recently, we use Coverity to analysis the ndctl package.
> Several issues should be resolved to make Coverity happy.
> 
> lihaotian9 (8):
>   namespace: check whether pfn|dax|btt is NULL in setup_namespace
>   lib/libndctl: fix memory leakage problem in add_bus
>   libdaxctl: fix memory leakage in add_dax_region()
>   dimm: fix potential fd leakage in dimm_action()
>   util/help: check whether strdup returns NULL in exec_man_konqueror
>   lib/inject: check whether cmd is created successfully
>   libndctl: check whether ndctl_btt_get_namespace returns NULL in
>     callers
>   namespace: check whether seed is NULL in validate_namespace_options
> 
>  daxctl/lib/libdaxctl.c |  3 +++
>  ndctl/dimm.c           | 12 +++++++-----
>  ndctl/lib/inject.c     |  8 ++++++++
>  ndctl/lib/libndctl.c   |  1 +
>  ndctl/namespace.c      | 23 ++++++++++++++++++-----
>  test/libndctl.c        | 16 +++++++++++-----
>  test/parent-uuid.c     |  2 +-
>  util/help.c            |  8 +++++++-
>  util/json.c            |  3 +++
>  9 files changed, 59 insertions(+), 17 deletions(-)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
