Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61118150E5F
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 18:09:37 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 69E8810FC3195;
	Mon,  3 Feb 2020 09:12:39 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6A7CF10FC3190
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 09:12:36 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 013H85vP120224;
	Mon, 3 Feb 2020 12:09:07 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2xxbmn7hnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2020 12:09:05 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
	by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 013H1nmH018633;
	Mon, 3 Feb 2020 17:09:03 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
	by ppma01dal.us.ibm.com with ESMTP id 2xw0y6f590-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2020 17:09:03 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
	by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 013H91Ca49742286
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2020 17:09:01 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7465078063;
	Mon,  3 Feb 2020 17:09:01 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B9157805C;
	Mon,  3 Feb 2020 17:08:59 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.92.150])
	by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2020 17:08:58 +0000 (GMT)
X-Mailer: emacs 27.0.60 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH 1/5] mm/memremap_pages: Kill unused __devm_memremap_pages()
In-Reply-To: <158041476158.3889308.4221100673554151124.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <158041475480.3889308.655103391935006598.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158041476158.3889308.4221100673554151124.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Mon, 03 Feb 2020 22:38:56 +0530
Message-ID: <87y2tjfviv.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-03_06:2020-02-02,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=2 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030127
Message-ID-Hash: 53WZPCM2JWBVEGC5FB3V6DWBJBEBXOSU
X-Message-ID-Hash: 53WZPCM2JWBVEGC5FB3V6DWBJBEBXOSU
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/53WZPCM2JWBVEGC5FB3V6DWBJBEBXOSU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Kill this definition that was introduced in commit 41e94a851304 ("add
> devm_memremap_pages") add never used.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/io.h |    2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/io.h b/include/linux/io.h
> index a59834bc0a11..35e8d84935e0 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -79,8 +79,6 @@ void *devm_memremap(struct device *dev, resource_size_t offset,
>  		size_t size, unsigned long flags);
>  void devm_memunmap(struct device *dev, void *addr);
>  
> -void *__devm_memremap_pages(struct device *dev, struct resource *res);
> -
>  #ifdef CONFIG_PCI
>  /*
>   * The PCI specifications (Rev 3.0, 3.2.5 "Transaction Ordering and
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
