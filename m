Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538C016311
	for <lists+linux-nvdimm@lfdr.de>; Tue,  7 May 2019 13:50:09 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 77FD921237ABE;
	Tue,  7 May 2019 04:50:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aneesh.kumar@linux.ibm.com; receiver=linux-nvdimm@lists.01.org 
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D38D32122C318
 for <linux-nvdimm@lists.01.org>; Tue,  7 May 2019 04:50:04 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x47Bkosj009825
 for <linux-nvdimm@lists.01.org>; Tue, 7 May 2019 07:50:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2sb6b2rqsd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvdimm@lists.01.org>; Tue, 07 May 2019 07:50:04 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-nvdimm@lists.01.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 7 May 2019 12:50:01 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 7 May 2019 12:49:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x47Bnvdq62652642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 May 2019 11:49:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5DAAAE051;
 Tue,  7 May 2019 11:49:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01B7DAE04D;
 Tue,  7 May 2019 11:49:57 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.85.196.155])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue,  7 May 2019 11:49:56 +0000 (GMT)
X-Mailer: emacs 26.1 (via feedmail 11-beta-1 I)
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: dan.j.williams@intel.com
Subject: Re: [PATCH v2] drivers/dax: Allow to include DEV_DAX_PMEM as builtin
In-Reply-To: <20190401051421.17878-1-aneesh.kumar@linux.ibm.com>
References: <20190401051421.17878-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 07 May 2019 06:49:55 -0500
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19050711-0028-0000-0000-0000036B2C6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050711-0029-0000-0000-0000242AA536
Message-Id: <87pnoumql8.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-05-07_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=946 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905070078
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>


Hi Dan,

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This move the dependency to DEV_DAX_PMEM_COMPAT such that only
> if DEV_DAX_PMEM is built as module we can allow the compat support.
>
> This allows to test the new code easily in a emulation setup where we
> often build things without module support.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Any update on this. Can we merge this?

> ---
> Changes from V1:
> * Make sure we only build compat code as module
>
>  drivers/dax/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
> index 5ef624fe3934..a59f338f520f 100644
> --- a/drivers/dax/Kconfig
> +++ b/drivers/dax/Kconfig
> @@ -23,7 +23,6 @@ config DEV_DAX
>  config DEV_DAX_PMEM
>  	tristate "PMEM DAX: direct access to persistent memory"
>  	depends on LIBNVDIMM && NVDIMM_DAX && DEV_DAX
> -	depends on m # until we can kill DEV_DAX_PMEM_COMPAT
>  	default DEV_DAX
>  	help
>  	  Support raw access to persistent memory.  Note that this
> @@ -50,7 +49,7 @@ config DEV_DAX_KMEM
>  
>  config DEV_DAX_PMEM_COMPAT
>  	tristate "PMEM DAX: support the deprecated /sys/class/dax interface"
> -	depends on DEV_DAX_PMEM
> +	depends on m && DEV_DAX_PMEM=m
>  	default DEV_DAX_PMEM
>  	help
>  	  Older versions of the libdaxctl library expect to find all
> -- 
> 2.20.1

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
