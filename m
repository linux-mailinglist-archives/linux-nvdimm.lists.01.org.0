Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AECB7DBF
	for <lists+linux-nvdimm@lfdr.de>; Thu, 19 Sep 2019 17:11:03 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 478A321962301;
	Thu, 19 Sep 2019 08:10:07 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 2D36C2194EB70
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:10:05 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g13so3372558otp.8
 for <linux-nvdimm@lists.01.org>; Thu, 19 Sep 2019 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rbAvn/fLEtrrbaQbOBPcQV2Gd+t+4OCja+ZvjJ+cvBY=;
 b=1tUJ1PV5mp5IFCPouteKt3ZHHGTdt7tsLvMkNNjDewW8VoSvN+XLXF75M/Is74D3NX
 /Ts89zWuG0b9DurQK4RyN4w8Dv8lRCU6F8V0Wne64w8HLeOLHnXv2k7FjjsHhiDDm2Cu
 xd6XrQM0bhxGG0sUbUsKjwsQZeG/w4f/dO+t2bkNV9cyzFQDvoyEQOTIAckAwse0IgVt
 Fejzt6tKAecO1Hgp6jQz2laXGISoch4eR/B32uZdyP6TJf30C8fNhDuU5CrWSewLD2W7
 GX7nPKU8SPLS8wrwiCj/b5t8qUwMhxGgW3Y5c6fEeUIlHBlMcF7nMhnmkwzm30nztZQk
 onTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rbAvn/fLEtrrbaQbOBPcQV2Gd+t+4OCja+ZvjJ+cvBY=;
 b=cDDgCGH+8/V7xYNHRWSuvGvHqKgCsN9WVU7AU7doEnurxv42/W9jY9RuVhfT0dT9Qs
 zGMOAGA2s53UtouRC/+rBoJqMAxqek2jbRcEl9sBVOfTNN5V5OeZEykOg4Vpl6mBUiK7
 w5DZIl3WAAVZ/fzC9pewHQVizGlEAgqDanU1YQhHT+3Us/r613RXr1u5tCsj3NorL1V0
 PdqvUw8sq1Heg6oynNE+wdc6jdj/JGEZAVOxS+UKJL0yMJrJtIpg5tkgT4SwamB3iLg9
 rHmE0fa0Fdf4boTBoE8FvcJhhEuuApf+6di0g3A7OR+9YY7otAxZDgy/yFJ4zQvGoFrq
 4poQ==
X-Gm-Message-State: APjAAAWL1OLREK9f8wBlr107LKj85K0IZe1YWzDn5K1JkrP0mgMIKAna
 j9F2lXEiHygctqfY/XYga+pYqTEITDEtXQrxJcRkPQ==
X-Google-Smtp-Source: APXvYqx2S5k+z4ZGv2dic61Adqm9i+k8xPppFEEZfMjADh6MmXT7takWWFxweMitbxwXrHeLHzlFZr+Ek6IOIK/zQss=
X-Received: by 2002:a9d:6014:: with SMTP id h20mr6930613otj.207.1568905858399; 
 Thu, 19 Sep 2019 08:10:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190919115547.GA17963@angband.pl>
In-Reply-To: <20190919115547.GA17963@angband.pl>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 19 Sep 2019 08:10:47 -0700
Message-ID: <CAPcyv4jYE_vmEqe+m7spaXV4FDgHLJpE9cp3Ry2e8vU0JZEFCA@mail.gmail.com>
Subject: Re: hang in dax_pmem_compat_release on changing namespace mode
To: Adam Borowski <kilobyte@angband.pl>
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

On Thu, Sep 19, 2019 at 4:56 AM Adam Borowski <kilobyte@angband.pl> wrote:
>
> Hi!
> If I try to change the mode of a devdax namespace that's in use (mapped by
> some process), ndctl hangs:

Is it merely mapped, or might the pages be actively pinned / in use by
another part of the kernel? The kernel has no choice but to wait for
active page pins to drain. Can you get a stack trace of the process
with the dev-dax instance mapped?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
