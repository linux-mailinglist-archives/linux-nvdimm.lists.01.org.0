Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656E435EC33
	for <lists+linux-nvdimm@lfdr.de>; Wed, 14 Apr 2021 07:25:41 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 38564100F225C;
	Tue, 13 Apr 2021 22:25:38 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.249.212.35; helo=szxga07-in.huawei.com; envelope-from=shikemeng@huawei.com; receiver=<UNKNOWN> 
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 336D2100F2257
	for <linux-nvdimm@lists.01.org>; Tue, 13 Apr 2021 22:25:35 -0700 (PDT)
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FKrTw06r5zB0gt;
	Wed, 14 Apr 2021 13:23:16 +0800 (CST)
Received: from [10.174.177.246] (10.174.177.246) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 14 Apr 2021 13:25:31 +0800
Subject: Re: [PATCH] x86: Accelerate copy_page with non-temporal in X86
To: Borislav Petkov <bp@alien8.de>
References: <3f28adee-8214-fa8e-b368-eaf8b193469e@huawei.com>
 <20210413110137.GD16519@zn.tnic>
 <bfa4fd38-0874-63b3-991a-1102af9f47a6@huawei.com>
 <20210413145315.GF16519@zn.tnic>
From: Kemeng Shi <shikemeng@huawei.com>
Message-ID: <7854092f-f37a-f95c-132a-1b2896d582fc@huawei.com>
Date: Wed, 14 Apr 2021 13:25:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20210413145315.GF16519@zn.tnic>
X-Originating-IP: [10.174.177.246]
X-CFilter-Loop: Reflected
Message-ID-Hash: D7LAN65Z6TCSQTA47D2OHIF5HACCJDCH
X-Message-ID-Hash: D7LAN65Z6TCSQTA47D2OHIF5HACCJDCH
X-MailFrom: shikemeng@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/D7LAN65Z6TCSQTA47D2OHIF5HACCJDCH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



on 2021/4/13 22:53, Borislav Petkov wrote:
> I thought "should be better" too last time when I measured rep; movs vs
> NT stores but actual measurements showed no real difference.
Mabye the NT stores make difference when store to slow dimms, like the
persistent memory I just tested. Also, it likely reduces unnecessary cache
load and flush, and benifits the running processes which have data cached.

-- 
Best wishes
Kemeng Shi
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
