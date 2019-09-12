Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128DB14FF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 22:01:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 34D22202E6DFF;
	Thu, 12 Sep 2019 13:01:34 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.85.215.196; helo=mail-pg1-f196.google.com;
 envelope-from=bart.vanassche@gmail.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 589E0202BCBB6
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 13:01:32 -0700 (PDT)
Received: by mail-pg1-f196.google.com with SMTP id u72so14011699pgb.10
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 13:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ShxzRkwVpFXPFUhCMkn8w2H4SHeQQrrLJDUeQMUdcI=;
 b=EhJYENjEGWgNRdipwmnmfyzfeoGp8wWdsKcx+MQiq+CxaQtCwrGplR/DhKuwLhH9Eo
 GJC8jsCcTGNwFvwvR2CJkVbG3Ong7zTOunKNW72PTaXT86yD3d1wiKprBKDKlmSJrL7P
 tlPNKYDN95lkKSjytt4+cglFDVhQdyXefLljPZ2jlg43VNLRHyo9BgUCQdFj6+mRHLiC
 MgpE6ro2hwlhFXxxAhLMZYjk4X2wHThzXXzJM1+2boUNUv7TdjvnhRH88WKP4g1T9NyG
 Ei3vdrVtfDVNV/GlEfwHmBVM6rmvIVVrbfUNbcVyAbmjW92UWawrpxlU41QqMEWIVgXK
 nfjA==
X-Gm-Message-State: APjAAAXsas1MDvWh2nCaDCkQFK2y+E3Njh2q+9OCUcBhEeyUvG/+GJqV
 uaTPEhUkxCpUDge8brII1Xo=
X-Google-Smtp-Source: APXvYqyry5egiR7l6s0aQO4rPH0UT6pfvHSg90vmXu4bIiK4MHA+WwyQh+uKxb6FVD5SJXGN+IyDag==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr23647280pgj.344.1568318491686; 
 Thu, 12 Sep 2019 13:01:31 -0700 (PDT)
Received: from [192.168.43.134] ([38.98.37.138])
 by smtp.gmail.com with ESMTPSA id v43sm134470pjb.1.2019.09.12.13.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2019 13:01:30 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 0/3] Maintainer Entry Profiles
To: Joe Perches <joe@perches.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <yq1o8zqeqhb.fsf@oracle.com> <6fe45562-9493-25cf-afdb-6c0e702a49b4@acm.org>
 <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <74984dc0-d5e4-f272-34b9-9a78619d5a83@acm.org>
Date: Thu, 12 Sep 2019 13:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <44c08faf43fa77fb271f8dbb579079fb09007716.camel@perches.com>
Content-Language: en-US
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
Cc: ksummit-discuss@lists.linuxfoundation.org, linux-nvdimm@lists.01.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Steve French <stfrench@microsoft.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/12/19 8:34 AM, Joe Perches wrote:
> On Thu, 2019-09-12 at 14:31 +0100, Bart Van Assche wrote:
>> On 9/11/19 5:40 PM, Martin K. Petersen wrote:
>>> * The patch must compile without warnings (make C=1 CF="-D__CHECK_ENDIAN__")
>>>   and does not incur any zeroday test robot complaints.
>>
>> How about adding W=1 to that make command?
> 
> That's rather too compiler version dependent and new
> warnings frequently get introduced by new compiler versions.

I've never observed this myself. If a new compiler warning is added to
gcc and if it produces warnings that are not useful for kernel code
usually Linus or someone else is quick to suppress that warning.

Another argument in favor of W=1 is that the formatting of kernel-doc
headers is checked only if W=1 is passed to make.

Bart.

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
