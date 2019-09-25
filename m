Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D632BBD6DC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 25 Sep 2019 05:51:17 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id B937821962301;
	Tue, 24 Sep 2019 20:53:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 49EBF202BB9C2
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 20:53:32 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8P3kpLo084504; Tue, 24 Sep 2019 23:51:07 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2v7x9hcc5h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 24 Sep 2019 23:51:07 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8P3jr8d018868;
 Wed, 25 Sep 2019 03:51:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01wdc.us.ibm.com with ESMTP id 2v5bg72eyp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Sep 2019 03:51:07 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8P3p6PJ12452738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Sep 2019 03:51:06 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2069B2805A;
 Wed, 25 Sep 2019 03:51:06 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 93CB028058;
 Wed, 25 Sep 2019 03:51:04 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.47.34])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 25 Sep 2019 03:51:04 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6] mm/pgmap: Use correct alignment when looking at first
 pfn from a region
In-Reply-To: <20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
References: <20190917153129.12905-1-aneesh.kumar@linux.ibm.com>
 <20190919122501.df660f0d23806a3f46d11b61@linux-foundation.org>
Date: Wed, 25 Sep 2019 09:21:02 +0530
Message-ID: <8736glowyh.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-25_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=782 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909250036
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: linux-mm@kvack.org, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Andrew Morton <akpm@linux-foundation.org> writes:

> On Tue, 17 Sep 2019 21:01:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
>> vmem_altmap_offset() adjust the section aligned base_pfn offset.
>> So we need to make sure we account for the same when computing base_pfn.
>> 
>> ie, for altmap_valid case, our pfn_first should be:
>> 
>> pfn_first = altmap->base_pfn + vmem_altmap_offset(altmap);
>
> What are the user-visible runtime effects of this change?

This was found by code inspection. If the pmem region is not correctly
section aligned we can skip pfns while iterating device pfn using 
	for_each_device_pfn(pfn, pgmap)


I still would want Dan to ack the change though.

-aneesh
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
