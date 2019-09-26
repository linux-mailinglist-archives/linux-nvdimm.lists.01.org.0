Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1E7BEBDC
	for <lists+linux-nvdimm@lfdr.de>; Thu, 26 Sep 2019 08:13:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 21D2921967BC5;
	Wed, 25 Sep 2019 23:15:24 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=dan.carpenter@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 583922010B845
 for <linux-nvdimm@lists.01.org>; Wed, 25 Sep 2019 23:15:22 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q69CP5032275;
 Thu, 26 Sep 2019 06:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vuTn9Ug2K8m9p3qflFzuiKxBa+JcRzAmvIsm6BbZjL4=;
 b=K893Qr8fsMQ97sRcjut+eb2X+a+PunWZQzrLzC98vFWqgrikAJrNf5NvY1cQOJdA21Z/
 ImVjyTWScbBziSn7ZFgG6fc7RzgRmk31pL9YAswNaiIwAFHxXWBPh8GlF2yDhlhju6jm
 bGAUd0vkdHN68CNWlFeClgjtkkaYNWUHbaw24Gtuk9ZaK0gyeRYjm476m1xJLpuKi9Pt
 v+C72R7e7hVpFb9UpjEPr847N+6Ch/2G0I/HF01ojA/5YMZvAIv0klKMThxZMXUN/Rpj
 xKpdkA3iMRx/oBNh6NnpScXldQTcyKV+FuL6NfwJRiRmfxbQqTFz6DoUe06ZBNHtoKyk mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2v5cgr988a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 06:13:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8Q67iKs052319;
 Thu, 26 Sep 2019 06:13:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2v82qbgrmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Sep 2019 06:13:09 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8Q6D8EM031875;
 Thu, 26 Sep 2019 06:13:08 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 25 Sep 2019 23:13:07 -0700
Date: Thu, 26 Sep 2019 09:12:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: ira.weiny@intel.com
Subject: Re: [PATCH V3] libnvdimm/namsepace: Don't set claim_class on error
Message-ID: <20190926061257.GE29696@kadam>
References: <20190925211348.14082-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190925211348.14082-1-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909260062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9391
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909260062
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

On Wed, Sep 25, 2019 at 02:13:48PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Don't leave claim_class set to an invalid value if an error occurs in
> btt_claim_class().
> 
> While we are here change the return type of __holder_class_store() to be
> clear about the values it is returning.
> 
> This was found via code inspection.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> V1->V2
> 	Add space after variable declaration...
> 
> V2->V3
> 	Fix oneliner
> 	Rebase without Dan Carpenter's patch and give him Reported-by
> 		credit

Thanks!  Btw, if it's ever a question of "do you want to redo a patch or
just transfer to reported by credit?" then always I always want the #2
option.  It would have taken me several iterations to generate the patch
you wanted.

regards,
dan carpenter

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
