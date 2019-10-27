Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2BEE6A3A
	for <lists+linux-nvdimm@lfdr.de>; Mon, 28 Oct 2019 00:41:51 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 63F98100EA616;
	Sun, 27 Oct 2019 16:42:45 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ajd@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 65B70100EA612
	for <linux-nvdimm@lists.01.org>; Sun, 27 Oct 2019 16:42:43 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9RNapb2043093
	for <linux-nvdimm@lists.01.org>; Sun, 27 Oct 2019 19:41:47 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2vvhsse8j2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvdimm@lists.01.org>; Sun, 27 Oct 2019 19:41:46 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-nvdimm@lists.01.org> from <ajd@linux.ibm.com>;
	Sun, 27 Oct 2019 23:41:43 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Sun, 27 Oct 2019 23:41:36 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9RNfZ5t42532890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 27 Oct 2019 23:41:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2B4A4059;
	Sun, 27 Oct 2019 23:41:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 331E5A4040;
	Sun, 27 Oct 2019 23:41:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Sun, 27 Oct 2019 23:41:35 +0000 (GMT)
Received: from [10.61.2.125] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9E6CDA026A;
	Mon, 28 Oct 2019 10:41:30 +1100 (AEDT)
Subject: Re: [PATCH 02/10] nvdimm: remove prototypes for nonexistent functions
To: "Alastair D'Silva" <alastair@au1.ibm.com>, alastair@d-silva.org
References: <20191025044721.16617-1-alastair@au1.ibm.com>
 <20191025044721.16617-3-alastair@au1.ibm.com>
From: Andrew Donnellan <ajd@linux.ibm.com>
Date: Mon, 28 Oct 2019 10:41:31 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191025044721.16617-3-alastair@au1.ibm.com>
Content-Language: en-AU
X-TM-AS-GCONF: 00
x-cbid: 19102723-4275-0000-0000-0000037838DF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102723-4276-0000-0000-0000388B6993
Message-Id: <0eb471be-9a88-3dbf-0d75-b109fc257974@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-27_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910270246
Message-ID-Hash: SRZQYHY7H63LW75MEVDQAS3RJRWK35JE
X-Message-ID-Hash: SRZQYHY7H63LW75MEVDQAS3RJRWK35JE
X-MailFrom: ajd@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Anton Blanchard <anton@ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>, Hari Bathini <hbathini@linux.ibm.com>, Anju T Sudhakar <anju@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>, linuxppc-dev@lists.ozlabs.org, lin
 ux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SRZQYHY7H63LW75MEVDQAS3RJRWK35JE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 25/10/19 3:46 pm, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> These functions don't exist, so remove the prototypes for them.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Indeed, they do not.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>   drivers/nvdimm/nd-core.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index 25fa121104d0..9f121a6aeb02 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -124,11 +124,7 @@ void nd_region_create_dax_seed(struct nd_region *nd_region);
>   int nvdimm_bus_create_ndctl(struct nvdimm_bus *nvdimm_bus);
>   void nvdimm_bus_destroy_ndctl(struct nvdimm_bus *nvdimm_bus);
>   void nd_synchronize(void);
> -int nvdimm_bus_register_dimms(struct nvdimm_bus *nvdimm_bus);
> -int nvdimm_bus_register_regions(struct nvdimm_bus *nvdimm_bus);
> -int nvdimm_bus_init_interleave_sets(struct nvdimm_bus *nvdimm_bus);
>   void __nd_device_register(struct device *dev);
> -int nd_match_dimm(struct device *dev, void *data);
>   struct nd_label_id;
>   char *nd_label_gen_id(struct nd_label_id *label_id, u8 *uuid, u32 flags);
>   bool nd_is_uuid_unique(struct device *dev, u8 *uuid);
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
