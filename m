Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9973B0564
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 00:11:36 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4E5AA202C8081;
	Wed, 11 Sep 2019 15:11:42 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=axboe@kernel.dk; receiver=linux-nvdimm@lists.01.org 
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C4D6920294F20
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 15:11:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n190so12261269pgn.0
 for <linux-nvdimm@lists.01.org>; Wed, 11 Sep 2019 15:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q6jLEHDrdAVkyK20fWjT39oclCB9S4iV/KFrjMBbJeE=;
 b=QVCVJyazN/1N3tJh29TNpXnPZfFboklNshuMEVATsFL73C4lZ3qdC9cIJwoWXu03no
 Yo+usfFGucs6trZ6+x8CKnsjWG1J93b4JdVgkzYxMZtJjlsmh6pRNhFufp6iwRTUeiZT
 MdmwZDKL3OJ4enBbnJjaALuEsrl8rx30ORRFnv2Jr+pCyQKgT/0b2/WOfiaT1DVa87G5
 Y2NPh7gy9tsZ00Phml674zGM20dJ/8cuZjGJDzYAsjA9Z6pGr2jo2reiYecdjUlWGfd6
 JNDirCjdVZwZUzGsqb5fF0iFPnLZXl4Rrnd4IZtgZ2f8Ofom94jQ2//HypL5e60Iw0+s
 WHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q6jLEHDrdAVkyK20fWjT39oclCB9S4iV/KFrjMBbJeE=;
 b=PGD7Ut4rGEzQo4spyQd8Mwv5FUiOBZvlKBva0aMxLyFjd6bVJwxYNrNL4sAYJIZDNr
 mIpK2y5SRVok19Ch0HEKnBsxsFfCwQXwyZJLSoH9GQtVByVff3Qj4fmLGT5hhThcCJ0R
 bpV4+j899rZfVVd7AdMQNzUBKydECIY3JCiC3kATs8toB3E56VIxMIa1EgJB+jIsQG8A
 urvpbO9a42GP6ZXEYjohTGArQNWV8Jt0RohkZOvxHZjxl/fIlAe/nhn9D0q05OrDyphu
 QDdDfjTdaDnsR/B9dcmAYpW7l+BukwAVZSQ2mIHAJ05DJvxTTwyOwqBTD0LMvsbxtlLL
 0PTw==
X-Gm-Message-State: APjAAAXC+XmgUjWjXlaQyQakdiAMv1IDdYkreSu/RxZjHomgVXK4XboO
 niY2NxoU0KY/jnTy8f3onUp/7w==
X-Google-Smtp-Source: APXvYqzc+AsW4ZOIn8LcwEkNbf6geCnMtHj/uM/luJQFVU08Hw7GR90DEjIbBO8Yfy27zfgzGqT8Rg==
X-Received: by 2002:a17:90a:fa3:: with SMTP id 32mr8129966pjz.35.1568239892801; 
 Wed, 11 Sep 2019 15:11:32 -0700 (PDT)
Received: from [192.168.1.188] ([23.158.160.160])
 by smtp.gmail.com with ESMTPSA id q4sm24322182pfh.115.2019.09.11.15.11.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 15:11:31 -0700 (PDT)
Subject: Re: [Ksummit-discuss] [PATCH v2 3/3] libnvdimm, MAINTAINERS:
 Maintainer Entry Profile
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
 <156821693963.2951081.11214256396118531359.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190911184332.GL20699@kadam>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <9132e214-9b57-07dc-7ee2-f6bc52e960c5@kernel.dk>
Date: Wed, 11 Sep 2019 16:11:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911184332.GL20699@kadam>
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
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On 9/11/19 12:43 PM, Dan Carpenter wrote:
> On Wed, Sep 11, 2019 at 08:48:59AM -0700, Dan Williams wrote:
>> +Coding Style Addendum
>> +---------------------
>> +libnvdimm expects multi-line statements to be double indented. I.e.
>> +
>> +        if (x...
>> +                        && ...y) {
> 
> That looks horrible and it causes a checkpatch warning.  :(  Why not
> do it the same way that everyone else does it.
> 
> 	if (blah_blah_x && <-- && has to be on the first line for checkpatch
> 	    blah_blah_y) { <-- [tab][space][space][space][space]blah
> 
> Now all the conditions are aligned visually which makes it readable.
> They aren't aligned with the indent block so it's easy to tell the
> inside from the if condition.
> 
> I kind of hate all this extra documentation because now everyone thinks
> they can invent new hoops to jump through.

FWIW, I completely agree with Dan (Carpenter) here. I absolutely
dislike having these kinds of files, and with subsystems imposing weird
restrictions on style (like the quoted example, yuck).

Additionally, it would seem saner to standardize rules around when
code is expected to hit the maintainers hands for kernel releases. Both
yours and Martins deals with that, there really shouldn't be the need
to have this specified in detail per sub-system.

-- 
Jens Axboe

_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
