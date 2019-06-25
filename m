Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C967155A96
	for <lists+linux-nvdimm@lfdr.de>; Wed, 26 Jun 2019 00:06:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5515D212A36DA;
	Tue, 25 Jun 2019 15:06:56 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 128752194EB7B
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:06:54 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w79so332816oif.10
 for <linux-nvdimm@lists.01.org>; Tue, 25 Jun 2019 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0SSgftr/ed9a2ur0BNJEdl/g8gNmPKoK7P+UZ//XX04=;
 b=dIeGVI+zVJSB5PTRRyqIYjX49diS9jl1hq2u5TnPxYIgoHNhdIvu84c/tcgEpwbquf
 QRontitejWNAukyFwTC6zrTdtdAC1+1RYwdLj9KoIR+QAay2rIbArGcXe+M5gdT6/kk4
 0YV70dEVDP0NZCD3YG94lbOIWZviJN540dk2/2dSFXcLQ23BUQWQhCMlh0Ze94oReQFi
 VLPod0VRRcRsE/PWGrHNPLORU60xXCvk1Csx9PvKYcobpNOtrI5gJ0nQWiIXeSOsaWKZ
 Z0Kd62RIY16QjdXnqf+JrlOoeECLTnbTVX8oJXZZagF0Agww5wqQUakO6gnyhCcHu31g
 +Edw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0SSgftr/ed9a2ur0BNJEdl/g8gNmPKoK7P+UZ//XX04=;
 b=XXzvFseJxRD2Bect4KKtkBAqUUFNPJFSlfhAM0KWZ7eN49PAuvXUps2KPOKP3nQjBm
 mB8nTMbmvYBFFmwgAEbK8uYj0DT1kEuJhWyE7D8HpBGDJ058EXMaYK1WJnJpqvKQNe34
 N6u6lwE/fkMlUkhnFj/akCwqx79yeCiKoEQPdI07H/Dz9GfB0vwIV1wX9JFqmODFt0P1
 9MBPaoXUOvNkC746Eccx9q+RWcAbsA/6bbze9Ttfits7gKoUQRmejv/4wX1I5lGyeen9
 CTYnV7aKhTXv5ZlubpQP4ar6glQ2iZUGfTstMTQoTCQWQyLs7GHtTE98cuZPIeERF8do
 99uw==
X-Gm-Message-State: APjAAAXl/dcmC6fzGtbYMupEHai56gFrzExb6G4bhHZuMn6aAT4XbHmP
 9O7b/1K8Wl+4ahujqKy6wwUBUmUdIvDwkihor3xMzg==
X-Google-Smtp-Source: APXvYqxljJeexEWm6aMZlwHgW23WBS4bUWiCwT1v520+eXVhCRHWUTb+RItq0rxxz0q3NpJGXvojtdkje6sgoMxHCD4=
X-Received: by 2002:aca:1304:: with SMTP id e4mr15852332oii.149.1561500413881; 
 Tue, 25 Jun 2019 15:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190116065144.3499-1-richardw.yang@linux.intel.com>
 <20190604031041.GA27794@richard>
In-Reply-To: <20190604031041.GA27794@richard>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 25 Jun 2019 15:06:42 -0700
Message-ID: <CAPcyv4j4xGmM5BGqQu9Y2RFDa55Y0AMOn9Z0jXra334igBtwgA@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm, namespace: check nsblk->uuid immediately after
 its allocation
To: Wei Yang <richardw.yang@linux.intel.com>
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
Cc: Ross Zwisler <zwisler@kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, Jun 3, 2019 at 8:11 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> Hi, Dan
>
> Do you have some time on this?
>
> On Wed, Jan 16, 2019 at 02:51:44PM +0800, Wei Yang wrote:
> >When creating nd_namespace_blk, its uuid is copied from nd_label->uuid.
> >In case the memory allocation fails, it goes to the error branch.
> >
> >This check is better to be done immediately after memory allocation,
> >while current implementation does this after assigning claim_class.
> >
> >This patch moves the check immediately after uuid allocation.

This looks ok, but the patch has no significant impact. I'm not
particularly motivated to carry it forward.
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
