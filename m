Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A89A227E
	for <lists+linux-nvdimm@lfdr.de>; Thu, 29 Aug 2019 19:38:47 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8DDC92021DD42;
	Thu, 29 Aug 2019 10:40:38 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id E6CB92021B701
 for <linux-nvdimm@lists.01.org>; Thu, 29 Aug 2019 10:40:36 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7THYE4K125929;
 Thu, 29 Aug 2019 17:38:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=qbXiEXHYRoSXRpZWGfIp8DXD6YL1dzTwP19l7H8djVc=;
 b=qGvMgX3b2ypd7Xf5QIUYRuGsov7IfnIIimkKRI/f+R3Lwj7xJVX3AOpPaPGRbib/4fST
 8OueF+st++fQY6IU+xECXV7QNjehk4H5g8WCdP0dlvsVp78H8/FD8KNBLj41zsdVhXTe
 FDwerqTuKFvGA4KX6ENp2b8ldRNneojGsLV/nh1lM2Jam6QNXPQRPkc+2Qhe/2t055z5
 Y94pt8TT4cI1Nqhx+L0iYBmefq8/VjfWLkgXrRqf7Vv4N2LJwOttLXwp//GD2qps6r2K
 c576KvYJALdPlegqS8ltGVherX01GuMZpxLIJDvxG6pj4/tf+3WmrDXFyqFJIYgNZnKT fg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2upk56r2qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 17:38:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7THWaBt180560;
 Thu, 29 Aug 2019 17:38:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 2untevcxn0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Aug 2019 17:38:42 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7THcfdo025735;
 Thu, 29 Aug 2019 17:38:42 GMT
Received: from [10.132.92.146] (/10.132.92.146)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 29 Aug 2019 10:38:41 -0700
Subject: Re: [ndctl PATCH 3/3] ndctl/namespace: add a --continue option to
 create namespaces greedily
To: Vishal Verma <vishal.l.verma@intel.com>, linux-nvdimm@lists.01.org
References: <20190829001735.30289-1-vishal.l.verma@intel.com>
 <20190829001735.30289-4-vishal.l.verma@intel.com>
From: jane.chu@oracle.com
Organization: Oracle Corporation
Message-ID: <179261bd-9812-6bba-6710-19a77cf3acc6@oracle.com>
Date: Thu, 29 Aug 2019 10:38:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829001735.30289-4-vishal.l.verma@intel.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290186
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9364
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290186
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
Cc: Steve Scargall <steve.scargall@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi, Vishal,


On 8/28/19 5:17 PM, Vishal Verma wrote:
> Add a --continue option to ndctl-create-namespaces to allow the creation
> of as many namespaces as possible, that meet the given filter
> restrictions.
> 
> The creation loop will be aborted if a failure is encountered at any
> point.

Just wondering what is the motivation behind providing this option?

thanks!
-jane

> 
> Link: https://github.com/pmem/ndctl/issues/106
> Reported-by: Steve Scargal <steve.scargall@intel.com>
> Cc: Jeff Moyer <jmoyer@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>   .../ndctl/ndctl-create-namespace.txt          |  7 ++++++
>   ndctl/namespace.c                             | 25 +++++++++++++++----
>   2 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ndctl/ndctl-create-namespace.txt b/Documentation/ndctl/ndctl-create-namespace.txt
> index c9ae27c..55a8581 100644
> --- a/Documentation/ndctl/ndctl-create-namespace.txt
> +++ b/Documentation/ndctl/ndctl-create-namespace.txt
> @@ -215,6 +215,13 @@ include::xable-region-options.txt[]
>   --bus=::
>   include::xable-bus-options.txt[]
>   
> +-c::
> +--continue::
> +	Do not stop after creating one namespace. Instead, greedily create as
> +	many namespaces as possible within the given --bus and --region filter
> +	restrictions. This will abort if any creation attempt results in an
> +	error.
> +
>   include::../copyright.txt[]
>   
>   SEE ALSO
> diff --git a/ndctl/namespace.c b/ndctl/namespace.c
> index af20a42..8d6b249 100644
> --- a/ndctl/namespace.c
> +++ b/ndctl/namespace.c
> @@ -41,6 +41,7 @@ static struct parameters {
>   	bool do_scan;
>   	bool mode_default;
>   	bool autolabel;
> +	bool greedy;
>   	const char *bus;
>   	const char *map;
>   	const char *type;
> @@ -114,7 +115,9 @@ OPT_STRING('t', "type", &param.type, "type", \
>   OPT_STRING('a', "align", &param.align, "align", \
>   	"specify the namespace alignment in bytes (default: 2M)"), \
>   OPT_BOOLEAN('f', "force", &force, "reconfigure namespace even if currently active"), \
> -OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels")
> +OPT_BOOLEAN('L', "autolabel", &param.autolabel, "automatically initialize labels"), \
> +OPT_BOOLEAN('c', "continue", &param.greedy, \
> +	"continue creating namespaces as long as the filter criteria are met")
>   
>   #define CHECK_OPTIONS() \
>   OPT_BOOLEAN('R', "repair", &repair, "perform metadata repairs"), \
> @@ -1365,8 +1368,11 @@ static int do_xaction_namespace(const char *namespace,
>   				rc = namespace_create(region);
>   				if (rc == -EAGAIN)
>   					continue;
> -				if (rc == 0)
> -					*processed = 1;
> +				if (rc == 0) {
> +					(*processed)++;
> +					if (param.greedy)
> +						continue;
> +				}
>   				return rc;
>   			}
>   			ndctl_namespace_foreach_safe(region, ndns, _n) {
> @@ -1427,9 +1433,15 @@ static int do_xaction_namespace(const char *namespace,
>   		/*
>   		 * Namespace creation searched through all candidate
>   		 * regions and all of them said "nope, I don't have
> -		 * enough capacity", so report -ENOSPC
> +		 * enough capacity", so report -ENOSPC. Except during
> +		 * greedy namespace creation using --continue as we
> +		 * may have created some namespaces already, and the
> +		 * last one in the region search may preexist.
>   		 */
> -		rc = -ENOSPC;
> +		if (param.greedy && (*processed) > 0)
> +			rc = 0;
> +		else
> +			rc = -ENOSPC;
>   	}
>   
>   	return rc;
> @@ -1487,6 +1499,9 @@ int cmd_create_namespace(int argc, const char **argv, struct ndctl_ctx *ctx)
>   		rc = do_xaction_namespace(NULL, ACTION_CREATE, ctx, &created);
>   	}
>   
> +	if (param.greedy)
> +		fprintf(stderr, "created %d namespace%s\n", created,
> +			created == 1 ? "" : "s");
>   	if (rc < 0 || (!namespace && created < 1)) {
>   		fprintf(stderr, "failed to %s namespace: %s\n", namespace
>   				? "reconfigure" : "create", strerror(-rc));
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
