Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE61A9E2D6
	for <lists+linux-nvdimm@lfdr.de>; Tue, 27 Aug 2019 10:39:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7BC0E20216B61;
	Tue, 27 Aug 2019 01:41:39 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id B5C2C20215F75
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 01:41:38 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7R8YCUd076604
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 04:39:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2umxkvw6tx-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Tue, 27 Aug 2019 04:39:26 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 27 Aug 2019 09:39:24 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Aug 2019 09:39:21 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x7R8dKxq43712880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Aug 2019 08:39:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 05A204C040;
 Tue, 27 Aug 2019 08:39:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47BCE4C04A;
 Tue, 27 Aug 2019 08:39:19 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.124.35.114])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 27 Aug 2019 08:39:19 +0000 (GMT)
X-Mailer: emacs 26.2 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com, vishal.l.verma@intel.com
Subject: Re: [PATCH] ndctl: Use the same align value as original namespace on
 reconfigure
In-Reply-To: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com>
References: <20190807044416.30799-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 27 Aug 2019 14:09:18 +0530
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19082708-0020-0000-0000-000003646781
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082708-0021-0000-0000-000021B9B31C
Message-Id: <87ftlnm289.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-27_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908270096
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


Hi Dan/Vishal,

Any update on this?

-aneesh

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> When using reconfigure command to add a `name` to the namespace we end
> up updating the align attribute. Avoid this by using the value from
> the original namespace. Do this only if we are keeping the namespace mode
> same.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  ndctl/namespace.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index 1f212a2b3a9b..24e51bb35ae1 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -596,6 +596,22 @@ static int validate_namespace_options(struct ndctl_region *region,
>  			return -ENXIO;
>  		}
>  	} else {
> +
> +		/*
> +		 * If we are tryint to reconfigure with the same namespace mode
> +		 * Use the align details from the origin namespace. Otherwise
> +		 * pick the align details from seed namespace
> +		 */
> +		if (ndns && p->mode == ndctl_namespace_get_mode(ndns)) {
> +			struct ndctl_pfn *ns_pfn = ndctl_namespace_get_pfn(ndns);
> +			struct ndctl_dax *ns_dax = ndctl_namespace_get_dax(ndns);
> +			if (ns_pfn)
> +				p->align = ndctl_pfn_get_align(ns_pfn);
> +			else if (ns_dax)
> +				p->align = ndctl_dax_get_align(ns_dax);
> +			else
> +				p->align = sysconf(_SC_PAGE_SIZE);
> +		} else
>  		/*
>  		 * Use the seed namespace alignment as the default if we need
>  		 * one. If we don't then use PAGE_SIZE so the size_align
> -- 
> 2.21.0

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
