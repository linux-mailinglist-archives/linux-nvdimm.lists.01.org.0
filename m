Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD8E245C5
	for <lists+linux-nvdimm@lfdr.de>; Tue, 21 May 2019 03:53:26 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 7DB7321274218;
	Mon, 20 May 2019 18:53:25 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.86; helo=userp2130.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C163821274209
 for <linux-nvdimm@lists.01.org>; Mon, 20 May 2019 18:53:23 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L1oQ3S041273;
 Tue, 21 May 2019 01:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yVkvZ8fXUaw/jTaRiqp6doEQkt1RyJ1CKsPrkEb5+Mc=;
 b=GtdEhsmE9R4Zp5z5vZMf9BbUL5SfV6BWLtuTdxklSLGncygnasVo0c0idEhjz950KX2U
 BBQDdYFcF4q0kwxRhRiahcfDSy01chn+f/yI7aH7kB0wAAagAmRFbx0J5gyrqUkIYLJG
 xicAQtlDBoFpB7eujyAEG/d8c20PrPGfYBb1JqoL3s/50G6dlo+5STLSNi49LosJnOcY
 d8Tei/znbUWFLpq98487U3WBOWVJufze2kfUM4w6gnWij383V4nzLeLCUEsSOp3iW8Qv
 0VxNjmPohLFDyVK+zJpEcc+Ui9xwFv/6y2IzdmfYc1F5AU5rMwEq3aAszVy4BIpIYal5 CA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 2sj9ftabyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2019 01:53:17 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L1pSbK035907;
 Tue, 21 May 2019 01:53:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2sks1xwx3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2019 01:53:16 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4L1rG5A002361;
 Tue, 21 May 2019 01:53:16 GMT
Received: from [10.159.155.76] (/10.159.155.76)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 21 May 2019 01:53:15 +0000
Subject: Re: [PATCH] mm, memory-failure: clarify error message
To: Anshuman Khandual <anshuman.khandual@arm.com>, n-horiguchi@ah.jp.nec.com, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1558066095-9495-1-git-send-email-jane.chu@oracle.com>
 <512532de-4c09-626d-380f-58cef519166b@arm.com>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <a2be5833-2161-38b6-2569-46084207ee47@oracle.com>
Date: Mon, 20 May 2019 18:53:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <512532de-4c09-626d-380f-58cef519166b@arm.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210009
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=995 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210009
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 5/16/2019 9:48 PM, Anshuman Khandual wrote:

> On 05/17/2019 09:38 AM, Jane Chu wrote:
>> Some user who install SIGBUS handler that does longjmp out
> What the longjmp about ? Are you referring to the mechanism of catching the
> signal which was registered ?

Yes.

thanks,
-jane

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
