Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29510019F
	for <lists+linux-nvdimm@lfdr.de>; Mon, 18 Nov 2019 10:46:51 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4903E100DC2A2;
	Mon, 18 Nov 2019 01:47:50 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com; envelope-from=aneesh.kumar@linux.ibm.com; receiver=<UNKNOWN> 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 701EA100DC3FF
	for <linux-nvdimm@lists.01.org>; Mon, 18 Nov 2019 01:47:48 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI9gNoh018879;
	Mon, 18 Nov 2019 04:45:40 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2wayaw6q8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2019 04:45:40 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
	by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAI9jGsP023882;
	Mon, 18 Nov 2019 09:45:43 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by ppma01wdc.us.ibm.com with ESMTP id 2wa8r5s6hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Nov 2019 09:45:43 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAI9jcZ865864058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2019 09:45:38 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE5E6A047;
	Mon, 18 Nov 2019 09:45:38 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 205FF6A051;
	Mon, 18 Nov 2019 09:45:35 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.34.246])
	by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon, 18 Nov 2019 09:45:34 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Subject: Re: [PATCH v2 15/18] mm/numa: Skip NUMA_NO_NODE and online nodes in numa_map_to_online_node()
In-Reply-To: <157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157401267421.43284.2135775608523385279.stgit@dwillia2-desk3.amr.corp.intel.com> <157401275716.43284.13185549705765009174.stgit@dwillia2-desk3.amr.corp.intel.com>
Date: Mon, 18 Nov 2019 15:15:33 +0530
Message-ID: <87wobxh60y.fsf@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180087
Message-ID-Hash: 3VNDNLOMO4PQRN5LUAOA55A6HVEQCIMA
X-Message-ID-Hash: 3VNDNLOMO4PQRN5LUAOA55A6HVEQCIMA
X-MailFrom: aneesh.kumar@linux.ibm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: peterz@infradead.org, dave.hansen@linux.intel.com, hch@lst.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/3VNDNLOMO4PQRN5LUAOA55A6HVEQCIMA/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dan Williams <dan.j.williams@intel.com> writes:

> Update numa_map_to_online_node() to stop falling back to numa node 0
> when the input is NUMA_NO_NODE. Also, skip the lookup if @node is
> online. This makes the routine compatible with other arch node mapping
> routines.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>
> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/mempolicy.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index e2d8dd21ce9d..d618121bcc17 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -137,8 +137,8 @@ int numa_map_to_online_node(int node)
>  {
>  	int min_node;
>  
> -	if (node == NUMA_NO_NODE)
> -		node = 0;
> +	if (node == NUMA_NO_NODE || node_online(node))
> +		return node;
>  
>  	min_node = node;
>  	if (!node_online(node)) {
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
