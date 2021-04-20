Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9378E365005
	for <lists+linux-nvdimm@lfdr.de>; Tue, 20 Apr 2021 03:55:03 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 79560100EB83B;
	Mon, 19 Apr 2021 18:55:01 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=59.111.176.151; helo=m176151.mail.qiye.163.com; envelope-from=wanjiabing@vivo.com; receiver=<UNKNOWN> 
Received: from m176151.mail.qiye.163.com (m176151.mail.qiye.163.com [59.111.176.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id F2F07100EBB75
	for <linux-nvdimm@lists.01.org>; Mon, 19 Apr 2021 18:54:58 -0700 (PDT)
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
	by m176151.mail.qiye.163.com (Hmail) with ESMTP id C2DEB48456E;
	Tue, 20 Apr 2021 09:54:55 +0800 (CST)
Message-ID: <AA2A4wAIDqypc6Mea5E07Kq1.3.1618883695772.Hmail.wanjiabing@vivo.com>
To: Ira Weiny <ira.weiny@intel.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gbGlibnZkaW1tLmg6IFJlbW92ZSBkdXBsaWNhdGUgc3RydWN0IGRlY2xhcmF0aW9u?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 36.152.145.182
In-Reply-To: <20210419160411.GG1904484@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Received: from wanjiabing@vivo.com( [36.152.145.182) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 20 Apr 2021 09:54:55 +0800 (GMT+08:00)
From: Jiabing Wan <wanjiabing@vivo.com>
Date: Tue, 20 Apr 2021 09:54:55 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
	oVCBIfWUFZQ0oaH1ZIQhhMTUJKQxkeTkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
	hKTFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU1JQk1NT0xNSElLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
	WUc6Okk6Tww6Mj8KAgsYTTYeGk4#S0wwCkpVSFVKTUpDQ0NITUJNSkpKVTMWGhIXVQwaFRESGhkS
	FRw7DRINFFUYFBZFWVdZEgtZQVlITVVKTklVSk9OVUpDSVlXWQgBWUFITENCNwY+
X-HM-Tid: 0a78ecfcd4ba93b5kuwsc2deb48456e
Message-ID-Hash: EOU6EOZMWE4JEPLRCKJCXSR4VBDLDDJL
X-Message-ID-Hash: EOU6EOZMWE4JEPLRCKJCXSR4VBDLDDJL
X-MailFrom: wanjiabing@vivo.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, kael_w@yeah.net
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/EOU6EOZMWE4JEPLRCKJCXSR4VBDLDDJL/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 
>On Mon, Apr 19, 2021 at 07:27:25PM +0800, Wan Jiabing wrote:>> struct device is declared at 133rd line.
>> The declaration here is unnecessary. Remove it.
>> 
>> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
>> ---
>>  include/linux/libnvdimm.h | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> index 01f251b6e36c..89b69e645ac7 100644
>> --- a/include/linux/libnvdimm.h
>> +++ b/include/linux/libnvdimm.h
>> @@ -141,7 +141,6 @@ static inline void __iomem *devm_nvdimm_ioremap(struct device *dev,
>>  
>>  struct nvdimm_bus;
>>  struct module;
>> -struct device;
>>  struct nd_blk_region;
>
>What is the coding style preference for pre-declarations like this?  Should
>they be placed at the top of the file?
>
>The patch is reasonable but if the intent is to declare right before use for
>clarity, both devm_nvdimm_memremap() and nd_blk_region_desc() use struct
>device.  So perhaps this duplicate is on purpose?
>
>Ira

OK, my script just catch this duplicate.
And I will report the duplicate if there is no MACRO dependence.
But I hadn't thought of whether the duplicate is a prompt on purpose.
Sorry.

Thanks for your reply.
Wan Jiabing

>>  struct nd_blk_region_desc {
>>  	int (*enable)(struct nvdimm_bus *nvdimm_bus, struct device *dev);
>> -- 
>> 2.25.1
>> 


_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
