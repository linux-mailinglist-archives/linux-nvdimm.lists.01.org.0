Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE28BCE99
	for <lists+linux-nvdimm@lfdr.de>; Tue, 24 Sep 2019 18:57:45 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 84619202EF28C;
	Tue, 24 Sep 2019 10:00:04 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 91EE8202BB9BC
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 10:00:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 83so2299167oii.1
 for <linux-nvdimm@lists.01.org>; Tue, 24 Sep 2019 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WavXUkIbZOkmAmXGetKUTyG5idnIaMJNv9RKIIWr2YA=;
 b=isCPOHvVJAW2mQzRa/7dObrw0o897T9KLoJOB91hWjJdbXPTSFJQ6U18scTIJOtStT
 kFK2QWisFxXFUCGGei6kHip3kgSA0GYFrvx7QXoUvDee+6E3wyUng+DAhggVyQFE4WcI
 cf9q6bjTnQCxaJLatprZRZbkRmXs7/4KhJgClTug9BsN3yOCzZrySD3ydZcsfmVcloKY
 mPz6S3CTJWzJa3Het7Sj+Yv5xWEXgJyAPcRQUw/6HocZzjrwBNfN0BWlvdFCUfNeeqqa
 FeHn4nWr9MJpaXmPlnQbGJOJNy4Yjc0O8LGW0OEavPmLCnxIMiz15QuqhYhwighHaPdY
 qIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WavXUkIbZOkmAmXGetKUTyG5idnIaMJNv9RKIIWr2YA=;
 b=FYjk8UONxclWJ8lD/V9ygLVSn3+bKjxjKfPsDh3arH/hAVT6sbF5hnU3HwjVdaEoJF
 UEXx+EAqxIZMWOmqamQMP/4a/5gXU602YgL/r/+1JQiy7sxtNcCuEAGk9euRScVhPO/n
 Y7bjJ+sdHpDpx9+HmoyTQzschg3uKST0C29uFzqb8KYewyDHKl1ClNlRI3hBR6EPq7Q3
 BqNQbV/Jwt80BZs4AWrvP1Tpgyn3yWWBxm2/SZMnnuVkYYdhK48L0tJACO4UolzQxJSZ
 iwf6q1s+FTI7tAs740FLyJ9B8gNnbWxnW6NJHe7zRvvUhr5kQJ5agjm26QGoemarB0EN
 pYAA==
X-Gm-Message-State: APjAAAXZDD+iXpALLna8ETu4WHNgt/dgSYe2idmKTxkfRAM34sm738ro
 sbVldneAiLLyy08sFSWO4QxGMu+y9IQI4Jb2abtGbY4E
X-Google-Smtp-Source: APXvYqxQGniP4MW4+bgg83eFzxjRCbSCXnT50dQgLCfrvp4LKZ7lfVz86YUAqQFpdgfbrI5ccVZ3CUzmYh2Olq4X0tk=
X-Received: by 2002:aca:5dc3:: with SMTP id r186mr934314oib.73.1569344260396; 
 Tue, 24 Sep 2019 09:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20190924114327.14700-1-aneesh.kumar@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 24 Sep 2019 09:57:29 -0700
Message-ID: <CAPcyv4iQbM5R0dukZX8wCQx4dD8NAevQWnHWe4hC7kHBcDcNow@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/region: Update is_nvdimm_sync check to handle
 volatile regions
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 24, 2019 at 4:43 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> We should consider volatile regions synchronous so that we are resilient to
> OS crashes. This is needed when we have hypervisor like KVM exporting a ramdisk
> as pmem dimms.

We have a hard time understanding what agent is being referenced when
we use "we" in a patch changelog. We would prefer that we consider not
using "we" in favor of explicitly named agents, or otherwise review
the changelog to make sure that "we" is clearly discernable. We will
fix it up this time when applying, but we hope we have made it clear
how confusing liberal use of "we" can be.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
