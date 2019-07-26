Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0F75D84
	for <lists+linux-nvdimm@lfdr.de>; Fri, 26 Jul 2019 05:43:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 188A3212E13B2;
	Thu, 25 Jul 2019 20:46:02 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::242; helo=mail-oi1-x242.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id BA506212B5F06
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 20:45:59 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s184so39298986oie.9
 for <linux-nvdimm@lists.01.org>; Thu, 25 Jul 2019 20:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8OekQPpYF9FBTKRudJiw/frl6cPPuHWTQ4OOkSHAID0=;
 b=qGLN7ve1Mrvkvikolx7D5iiLq1qI4UakzAF6v8yueQ8lsULf07TjUUMnG//UQN8Nik
 5gvRJoyKgRkYT0yeC6XB7KKPbCguMLOZReJY8M4VXJJwt+wVQwIwFcyaXq0oWJzvSaZs
 wjP0rzPl6deP51RqP7KXLKGspRoynqzwkpkjTIZ1Epg422BfTZ1VqiARXH6yoBjxdIRC
 GTgpqI6zuUINpJa/8vDFYZL4EKUAcNtEKcMLQ43hIipPaqVL3+222iW3qudwIJSyNZWh
 Mycb3/u2ZM/RR+UyMCQcqidsdxyn7deAOItU9nnu0WiPz/hclubMMd82rOvMwvYj+h7e
 doWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8OekQPpYF9FBTKRudJiw/frl6cPPuHWTQ4OOkSHAID0=;
 b=WoLASEhw4XrCaSWEevNKU3MUKarO3Bb5bQTbssUqLHuiLYZEHIG4AFHUQpMNq3yTTf
 vLWkPTYrrfqWAgRH2S4lzQnsdnLwcfjGofpOJxZZdfGouKR40bjb9xW6CYPF0R8E9+nu
 iChm4cabXPcLMiKgGziHrHQCNN/KCE08hCSHSXINU5SeJtkiPdiAlIBdQlun5blm+IAS
 bmvx0/L92ieBYUwoAkLlaK0b+qK7lQVa45RjdEgORHvf8ojmjyx8I/MjAZsn+FCNguqy
 YYL+7O7fdYLF7tixMeJtO1g2dUre16C8TIYNJTB+31diEoci1wS1sFe8t6CxlWLB5RZ8
 Cn5g==
X-Gm-Message-State: APjAAAUDIZIJkWVLAXNJ/omVq3hdDfhmS4rtFX6HZD/eXHclnrzVES4/
 4krhzYax0L0ZKNCSD4bNEw/KeuJ9TUyN6R8KAX1bGg==
X-Google-Smtp-Source: APXvYqzXRLACsjqWZpzv8IRYUJiKwyJb38sesW8vXnDSHxPmxEiv3lJ38KBxbv08NYqKb2uPjm7omrqd+zwV/RiPhyk=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr45225939oig.105.1564112612078; 
 Thu, 25 Jul 2019 20:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190724215741.18556-1-vishal.l.verma@intel.com>
 <20190724215741.18556-14-vishal.l.verma@intel.com>
In-Reply-To: <20190724215741.18556-14-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 25 Jul 2019 20:43:20 -0700
Message-ID: <CAPcyv4hpxYM4z45-eUhjUA-USq6p+d4GQZ=D1wt4H=_=4rCUCQ@mail.gmail.com>
Subject: Re: [ndctl PATCH v7 13/13] test: Add a unit test for
 daxctl-reconfigure-device and friends
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pavel Tatashin <pasha.tatashin@soleen.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Wed, Jul 24, 2019 at 2:58 PM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Add a new unit test to test dax device reconfiguration and memory
> operations. This teaches test/common about daxctl, and adds an ACPI.NFIT
> bus variable. Since we have to operate on the ACPI.NFIT bus, the test is
> marked as destructive.
>

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm
