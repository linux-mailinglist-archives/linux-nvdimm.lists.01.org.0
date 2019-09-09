Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009BDADBFD
	for <lists+linux-nvdimm@lfdr.de>; Mon,  9 Sep 2019 17:18:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DEC6C21A070B6;
	Mon,  9 Sep 2019 08:18:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 414B021A07094
 for <linux-nvdimm@lists.01.org>; Mon,  9 Sep 2019 08:18:37 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x89FG9wF041819
 for <linux-nvdimm@lists.01.org>; Mon, 9 Sep 2019 11:18:11 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uws7w02tw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Mon, 09 Sep 2019 11:18:10 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 9 Sep 2019 16:18:09 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 9 Sep 2019 16:18:06 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x89FI5se29163688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2019 15:18:05 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C77711C04A;
 Mon,  9 Sep 2019 15:18:05 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 243E611C050;
 Mon,  9 Sep 2019 15:18:04 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.199.41.57])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2019 15:18:03 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [PATCH v5] mm/nvdimm: Fix endian conversion =?utf-8?Q?issues?=
 =?utf-8?Q?=C2=A0?=
In-Reply-To: <20190809074726.27815-1-aneesh.kumar@linux.ibm.com>
References: <20190809074726.27815-1-aneesh.kumar@linux.ibm.com>
Date: Mon, 09 Sep 2019 20:48:02 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19090915-0020-0000-0000-00000369D8BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090915-0021-0000-0000-000021BF5A85
Message-Id: <871rwp1ot1.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-09_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090155
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> nd_label->dpa issue was observed when trying to enable the namespace created
> with little-endian kernel on a big-endian kernel. That made me run
> `sparse` on the rest of the code and other changes are the result of that.
>
> Fixes: d9b83c756953 ("libnvdimm, btt: rework error clearing")
> Fixes: 9dedc73a4658 ("libnvdimm/btt: Fix LBA masking during 'free list' population")
>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes from V4:
> * Rebase to latest kernel
>
>  drivers/nvdimm/btt.c            | 8 ++++----
>  drivers/nvdimm/namespace_devs.c | 7 ++++---
>  2 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
> index a8d56887ec88..3e9f45aec8d1 100644
> --- a/drivers/nvdimm/btt.c
> +++ b/drivers/nvdimm/btt.c
> @@ -392,9 +392,9 @@ static int btt_flog_write(struct arena_info *arena, u32 lane, u32 sub,
>  	arena->freelist[lane].sub = 1 - arena->freelist[lane].sub;
>  	if (++(arena->freelist[lane].seq) == 4)
>  		arena->freelist[lane].seq = 1;
> -	if (ent_e_flag(ent->old_map))
> +	if (ent_e_flag(le32_to_cpu(ent->old_map)))
>  		arena->freelist[lane].has_err = 1;
> -	arena->freelist[lane].block = le32_to_cpu(ent_lba(ent->old_map));
> +	arena->freelist[lane].block = ent_lba(le32_to_cpu(ent->old_map));
>  
>  	return ret;
>  }
> @@ -560,8 +560,8 @@ static int btt_freelist_init(struct arena_info *arena)
>  		 * FIXME: if error clearing fails during init, we want to make
>  		 * the BTT read-only
>  		 */
> -		if (ent_e_flag(log_new.old_map) &&
> -				!ent_normal(log_new.old_map)) {
> +		if (ent_e_flag(le32_to_cpu(log_new.old_map)) &&
> +		    !ent_normal(le32_to_cpu(log_new.old_map))) {
>  			arena->freelist[i].has_err = 1;
>  			ret = arena_clear_freelist_error(arena, i);
>  			if (ret)
> diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
> index a9c76df12cb9..f779cb2b0c69 100644
> --- a/drivers/nvdimm/namespace_devs.c
> +++ b/drivers/nvdimm/namespace_devs.c
> @@ -1987,7 +1987,7 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
>  		nd_mapping = &nd_region->mapping[i];
>  		label_ent = list_first_entry_or_null(&nd_mapping->labels,
>  				typeof(*label_ent), list);
> -		label0 = label_ent ? label_ent->label : 0;
> +		label0 = label_ent ? label_ent->label : NULL;
>  
>  		if (!label0) {
>  			WARN_ON(1);
> @@ -2322,8 +2322,9 @@ static struct device **scan_labels(struct nd_region *nd_region)
>  			continue;
>  
>  		/* skip labels that describe extents outside of the region */
> -		if (nd_label->dpa < nd_mapping->start || nd_label->dpa > map_end)
> -			continue;
> +		if (__le64_to_cpu(nd_label->dpa) < nd_mapping->start ||
> +		    __le64_to_cpu(nd_label->dpa) > map_end)
> +				continue;
>  
>  		i = add_namespace_resource(nd_region, nd_label, devs, count);
>  		if (i < 0)
> -- 
> 2.21.0

Gentle reminder.

Dan - any update on this?

-aneesh

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
