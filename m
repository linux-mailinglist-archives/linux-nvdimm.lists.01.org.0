Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C661CF73E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 12 May 2020 16:37:15 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id BE9D4118FCDDF;
	Tue, 12 May 2020 07:34:42 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95B4A1173AD86
	for <linux-nvdimm@lists.01.org>; Tue, 12 May 2020 07:34:39 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CEb3lS040127;
	Tue, 12 May 2020 14:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iZX0vpfj4/FmfDVyUC3t3DN/LcDWMEdqRaJHSY+KNck=;
 b=i2geK7cGN8wVAmB/U87v0qnFX1QsR+WN2KKy8qIbb+ZositxYdc6rT4+ETuMUIi3Xjmj
 eX7DYE4M+zq4HYpt9DaOc7HzJrm4UDhvMlC+eTemHmsxN96P4VGD18ymE1Xh0hy3vZPY
 uwBSyd8DhPHJ+ooXn+PhWRrbZpM0jUy1nDKA0qYpVKZycQGp7gqWeAzUSxI0ZbIY1QCf
 24MMrrFizuvMUp9g6oM1XzMr4U0t6opTHWA39SjWztIEcXiJWxB7m2y9k6KRVyypT2vs
 r9tiTRBoAfxVs0UwJSn7xAFR6RIOl7GtLi4Ly/QRmQ+KyGVcg/XirDJmbnedcrsjm1Xp ww==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 30x3mbuccf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 May 2020 14:36:57 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CESNMe105391;
	Tue, 12 May 2020 14:36:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userp3020.oracle.com with ESMTP id 30x69tbdhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2020 14:36:56 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04CEasTW008459;
	Tue, 12 May 2020 14:36:54 GMT
Received: from [10.175.218.127] (/10.175.218.127)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 12 May 2020 07:36:54 -0700
Subject: Re: [PATCH 11/12] device-dax: Add dis-contiguous resource support
To: Dan Williams <dan.j.williams@intel.com>
References: <158500767138.2088294.17131646259803932461.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <d7043cad-076d-d065-f933-b772b4e9c131@oracle.com>
Date: Tue, 12 May 2020 15:36:50 +0100
MIME-Version: 1.0
In-Reply-To: <158500773552.2088294.8756587190550753100.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=5 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=5 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120110
Message-ID-Hash: ORUOGYMYE5KIRTUBNIG2FK4SN3MMK5F4
X-Message-ID-Hash: ORUOGYMYE5KIRTUBNIG2FK4SN3MMK5F4
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-mm@kvack.org, dave.hansen@linux.intel.com, hch@lst.de, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ORUOGYMYE5KIRTUBNIG2FK4SN3MMK5F4/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 3/23/20 11:55 PM, Dan Williams wrote:
> @@ -561,13 +580,26 @@ static int __alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  	if (start == U64_MAX)
>  		return -EINVAL;
>  
> +	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
> +			* (dev_dax->nr_range + 1), GFP_KERNEL);
> +	if (!ranges)
> +		return -ENOMEM;
> +
>  	alloc = __request_region(res, start, size, dev_name(dev), 0);
> -	if (!alloc)
> +	if (!alloc) {
> +		kfree(ranges);
>  		return -ENOMEM;
> +	}

Noticed this yesterday while looking at alloc_dev_dax_range().

Is it correct to free @ranges here on __request_region failure?

IIUC krealloc() would free dev_dax->ranges if it succeeds, leaving us without
any valid ranges if __request_region failure case indeed frees @ranges. These
@ranges are being used afterwards when we delete the interface and free the
assigned regions. Perhaps we should remove the kfree() above and set
dev_dax->ranges instead before __request_region; or alternatively change the
call order between krealloc and __request_region? FWIW, krealloc checks if the
object being reallocated already meets the requested size, so perhaps there's no
harm with going with the former.

	Joao
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
