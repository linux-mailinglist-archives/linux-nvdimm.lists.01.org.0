Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A96B09D1
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Sep 2019 10:00:49 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3ED7C21962301;
	Thu, 12 Sep 2019 01:00:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::341; helo=mail-ot1-x341.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 5E4B9202C80B7
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:00:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g16so10033160otp.8
 for <linux-nvdimm@lists.01.org>; Thu, 12 Sep 2019 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5qmb78FYDeqJwCvfIUFA64DMXds2PW8DdSpXeskuPq4=;
 b=LUE8CLyXWQcGt5ozi574sQ/J9n0AJBvhhr7mv+LYM7f/8vSmrjw+pFEvB6VjkLyi2t
 VykulW20DQEli1D3Mh2AuNGF45hqYL+SxnAJSDp01zHAp7mNNNUbKM/cre3vGpdeRS6H
 wy/2DOV2srDzpSUJ9zXH7YcwAPvdS4tOSNJEu2rY6jsa/6oo8fa3kREiLMB6QAxQBtaz
 E7jQbOT+uvfQSV/Cwgx6NmLW/9DJGQ2Q4QibUNeUoSN8y2iId9qV2HceqdpD3NzVa0jg
 RKOTKjKQdX+ORNbR4e7Wz/Z+71lOHkS+iVKdy00uIPl4ofTM9OQ2hBVdGTSodfBfBWV0
 NRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5qmb78FYDeqJwCvfIUFA64DMXds2PW8DdSpXeskuPq4=;
 b=Oxl5uk/MLEw5iJr9uDz1U3rC/XHA+VBUfRparmFG6h9w6RXZYZFqc9k60aCqxFWuQz
 xdnzIneYmJRttQwuFJUyWF1Pm7jj9OZwwIqll2MjLPBnqGOSFCwjtVFW1duBWa70+QUA
 6pPzzlE7FvOqWv9Pxm3kn7q7zjzLVxBwujreBivjGX5ZbN/8rtsmN1F0q17uy3q9DbTz
 +K+T97of6EmtjoNU4cAh+nO9gRsPRzto4RHUieGyGlWBfPnK1F5eCN2XB56hnJpOGTXf
 iSC4zTH1ojfY16rWZvRZB1PntNTOIqOmnjbxTMxEDlHoSjZpjSDVt7ScDEClO3j4Jlxo
 /SzA==
X-Gm-Message-State: APjAAAWrXSIZ/3IqvoicWKJOdRwnbEAZCEQuXGrDpqAwY8uMbe0/aKNG
 cBw49sbRUpIRSM6G5wvbfb+vX0wWVrlNDrx1SMB7hQ==
X-Google-Smtp-Source: APXvYqyNoKF90/9aOosnjKNEcyJn0PnaFlqebXAMnVcR447j+ePIeVT1xmancYwa1G/50/CDhUr+1E5BW/SAO4iY+u4=
X-Received: by 2002:a9d:5ccc:: with SMTP id r12mr8105329oti.71.1568275245893; 
 Thu, 12 Sep 2019 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568256705.git.joe@perches.com>
In-Reply-To: <cover.1568256705.git.joe@perches.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 12 Sep 2019 01:00:35 -0700
Message-ID: <CAPcyv4hzoSp-bFx19Yj71H7x3D66-TE4uCpcHm4S9sJsGtXugA@mail.gmail.com>
Subject: Re: [PATCH 00/13] nvdimm: Use more common kernel coding style
To: Joe Perches <joe@perches.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Hi Joe,

On Wed, Sep 11, 2019 at 7:55 PM Joe Perches <joe@perches.com> wrote:
>
> Rather than have a local coding style, use the typical kernel style.

I'd rather automate this. I'm going to do once-over with clang-format
and see what falls out.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
