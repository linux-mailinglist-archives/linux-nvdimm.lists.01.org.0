Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2CB23ABD3
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Aug 2020 19:51:56 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C72E5129A9141;
	Mon,  3 Aug 2020 10:51:54 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8B34E129A909B
	for <linux-nvdimm@lists.01.org>; Mon,  3 Aug 2020 10:51:51 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073HfwvR185594;
	Mon, 3 Aug 2020 17:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=BJlgC8gpeW+JpyNpqxR4bB2p3QaB/etkA9V9OMvw9V4=;
 b=UaSzJKUNyScl9W0jXdAzgk+wLhRnaxpOLu1BIGFAo/zgWZZwuy3M74udTdOFx9i6wTDB
 F5hk3SwJ601Qv66uFlYnRi7JSb4dytkgyPNylFgHqeISWmBGFU08RDgczqI1hlgbQVq4
 Q0tH8pUGFhhSIeVQA1Fpwk12jjoxYzCHgIsibgBIoNK9PPpjNA96DkeDBzzJAFlovGYc
 eEAfHTv34jfYdQnjPCJYRhSsFpqFpB2dk2cASEmj9yBAOtkC6ZZcfGv2zGEHFZlfp1FM
 AGM6cZgnl2tBZJG9jktqIfG6TM9Wd0L4oT4Fy2Mfxkg6V4duwBd4Z8mEgNfzdNRMJlf8 gA==
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
	by userp2120.oracle.com with ESMTP id 32n11myu40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 03 Aug 2020 17:51:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
	by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 073Hgm8Q067974;
	Mon, 3 Aug 2020 17:51:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3020.oracle.com with ESMTP id 32pdnnqchf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Aug 2020 17:51:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 073Hpk2M019633;
	Mon, 3 Aug 2020 17:51:46 GMT
Received: from [10.159.240.44] (/10.159.240.44)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 03 Aug 2020 10:51:46 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <4bff2fec-735d-df27-2d34-f00dac4caee6@oracle.com>
Date: Mon, 3 Aug 2020 10:51:44 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9702 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008030126
Message-ID-Hash: XBJEHCWJ7TJ3ME4IC5D7POMXJLEPQJ37
X-Message-ID-Hash: XBJEHCWJ7TJ3ME4IC5D7POMXJLEPQJ37
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/XBJEHCWJ7TJ3ME4IC5D7POMXJLEPQJ37/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi,

Any taker on this and next patch
   [PATCH 2/2] libnvdimm/security: ensure sysfs poll thread woke up and 
fetch updated attr
?
According to our test, they're bugs, and folks are waiting to get
the issues fixed.

Thanks!
-jane

On 7/24/2020 9:09 AM, Jane Chu wrote:
> Since
> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
> when issue
>   # ndctl sanitize-dimm nmem0 --overwrite
> then immediately check the 'security' attribute,
>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>   unlocked
> Actually the attribute stays 'unlocked' through out the entire overwrite
> operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
> that has both bits set indicating 'overwrite' and 'unlocked'.
> But security_show() checks the mutually exclusive bits before it checks
> the 'overwrite' bit at last. The order should be reversed.
> 
> The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
> assignment is replaced with 'nvdimm->sec.flags' assignment for
> the NVDIMM_MASTER type.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/nvdimm/dimm_devs.c | 4 ++--
>   drivers/nvdimm/security.c  | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8..5d72026 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
>   {
>   	struct nvdimm *nvdimm = to_nvdimm(dev);
>   
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> +		return sprintf(buf, "overwrite\n");
>   	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>   		return sprintf(buf, "disabled\n");
>   	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "unlocked\n");
>   	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "locked\n");
> -	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> -		return sprintf(buf, "overwrite\n");
>   	return -ENOTTY;
>   }
>   
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4cef69b..8f3971c 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>   	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>   	put_device(&nvdimm->dev);
>   	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>   }
>   
>   void nvdimm_security_overwrite_query(struct work_struct *work)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
