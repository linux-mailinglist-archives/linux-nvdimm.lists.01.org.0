Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05B837D9
	for <lists+linux-nvdimm@lfdr.de>; Tue,  6 Aug 2019 19:27:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 196AC21311BFA;
	Tue,  6 Aug 2019 10:29:44 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=156.151.31.85; helo=userp2120.oracle.com;
 envelope-from=jane.chu@oracle.com; receiver=linux-nvdimm@lists.01.org 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C15092130D7D0
 for <linux-nvdimm@lists.01.org>; Tue,  6 Aug 2019 10:29:42 -0700 (PDT)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76H9EFo095481;
 Tue, 6 Aug 2019 17:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=KBUngTRZprbO++Eb+szGpPG6NefHy8tBupTeXYUVbsM=;
 b=Ppt8cSQNMuK0Cq/KrKDv4sBs6V+5euexG+kJuUAW2rZ7KE1SqIiiyZen2HOIhzNtXxBp
 pqA01ddnGl2HWm/Ur+o9dovrqpeyz2bYPYz6MHnAuX/SHTUdwG3skheWxl3F45Yp+n0X
 YQdLb3l9sliqNLCd4G1eAD0kjGxi2qxVLWDSW7vmR1QEdXD5D/qRvQkqMqHoORK6cKqY
 x8Z2roijL6BTgtENjwGtPr5tncFhjidN7BjumSLgbQsj1ngea6xPSnMk228ZF7ndBOxb
 D2MZJ4OWR2Cr5V2blscrfjrat6zEHeZmfVq/qQYf9U2iT7ohsao4TntqWImMPPdBCZ0m 4Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2u52wr7jgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2019 17:27:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76H8NB6141112;
 Tue, 6 Aug 2019 17:27:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 2u75776pns-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 06 Aug 2019 17:27:07 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x76HR6K4005006;
 Tue, 6 Aug 2019 17:27:06 GMT
Received: from [10.159.248.227] (/10.159.248.227)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 06 Aug 2019 10:27:06 -0700
Subject: Re: [PATCH v3 1/2] mm/memory-failure.c clean up around tk
 pre-allocation
To: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
References: <1564092101-3865-1-git-send-email-jane.chu@oracle.com>
 <1564092101-3865-2-git-send-email-jane.chu@oracle.com>
 <20190801090651.GC31767@hori.linux.bs1.fc.nec.co.jp>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <cad86094-c9ce-7bc1-5342-2bb03b512e71@oracle.com>
Date: Tue, 6 Aug 2019 10:26:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801090651.GC31767@hori.linux.bs1.fc.nec.co.jp>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9341
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060156
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
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi, Naoya,

Thanks a lot!  v4 on the way. :)

-jane

On 8/1/2019 2:06 AM, Naoya Horiguchi wrote:
> On Thu, Jul 25, 2019 at 04:01:40PM -0600, Jane Chu wrote:
>> add_to_kill() expects the first 'tk' to be pre-allocated, it makes
>> subsequent allocations on need basis, this makes the code a bit
>> difficult to read. Move all the allocation internal to add_to_kill()
>> and drop the **tk argument.
>>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> 
> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> # somehow I sent 2 acks to 2/2, sorry about the noise.
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
