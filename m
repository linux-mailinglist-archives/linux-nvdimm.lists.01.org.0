Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE181496E1
	for <lists+linux-nvdimm@lfdr.de>; Sat, 25 Jan 2020 18:28:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id AFF5210097E08;
	Sat, 25 Jan 2020 09:31:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com; envelope-from=mrsohalarfanlatif16@gmail.com; receiver=<UNKNOWN> 
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BD83810097DFB
	for <linux-nvdimm@lists.01.org>; Sat, 25 Jan 2020 09:31:36 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id h23so5485166qkh.0
        for <linux-nvdimm@lists.01.org>; Sat, 25 Jan 2020 09:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QiAUw3cuvWlwlgDTPQsNazQvLEh9Tp9j/xIc/e3j8Tc=;
        b=DYV+ALO0keF952oP/4ITkcXu+otn0tYyLvf3eXvKYcUEk2/wDuIbcuWvpKhUjNpbUV
         VCkEIAZtXOI9MawQz2gEChHx6BpxMl6MVkEx91dqmnGORDR8kaOVUyu2aVntnDHDn5yw
         sAmmEdIettHNDncE7WfaEOi1q1gMsh7jwuql1BRkj7huXszbgc/uzV4pjQ7jB1OhIsmj
         Gjau3In1BBiRcy05B0ru2sD0p4KGrP0/Hkx6qIHC3zOUzfq92ndFNaUnbicO3dGu9aLL
         9aCk8yl3hMz+Lly0WiJmh9cjUFSUBwJD5Qadl0o2j9zHilPR4K0ngDkqnDYkxnFHHXPf
         scpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QiAUw3cuvWlwlgDTPQsNazQvLEh9Tp9j/xIc/e3j8Tc=;
        b=p5lZdAFs2O7VxajuW+N7Xg53x9gBrTwrkFy+DWl5kJh5IA71NHlEMhI/dntwXl7ULt
         iOBBvi95u1N5GnHDVlZWy9kFvRXSHd7TMbYLFpI3XgIL4Ng4yA92VFu1c99kAiiL40t2
         F+D32FqiWOjuyZ2G7/BMVBeDT02c8Vz4VhkV3qW4Vu6UjpkPwfZk8u1PsdG3ld44BHs6
         7vj3pU0QQ2NkwYL1ofkUutlMM1Yl038OJEdewGAyC5dLMuAhryp99nlBN7gTSg3l65fb
         ZMogNU/fsrhLdiqXHIDwIAE2d1YpNdV+Hsb+gkd8iXUW0wvYH143hlxu6miOawiAw1fs
         GUqw==
X-Gm-Message-State: APjAAAXI3UFhkA5iLVKCNc0HA/zVYIET81lNCcXemiZz3Kvogt265PpP
	3vWYl9Z5CQXuy5yW9YTKVQYi1iW1Ak7wLrmBXrM=
X-Google-Smtp-Source: APXvYqw6a4z/dvyI7pl3/qOrTW0NQ9C9TnPXjfj6jf+yVs/zBdRodvd03UOcptynGRmiG7uO12gbQyMhu2SqpWaDSKU=
X-Received: by 2002:a37:7245:: with SMTP id n66mr9273818qkc.202.1579973297781;
 Sat, 25 Jan 2020 09:28:17 -0800 (PST)
MIME-Version: 1.0
From: "Mr. Sohal Arfan Latif" <mrsohalarfanlatif@gmail.com>
Date: Sat, 25 Jan 2020 18:27:52 +0100
Message-ID: <CACjrGDgAL_TVN-iG3o1_xDLo2fKfNXNuk_TX3fgnTvfFz0oMFQ@mail.gmail.com>
Subject: Dear Friend,
To: undisclosed-recipients:;
Message-ID-Hash: G2ROKTPFIPYIOG5ZUTZJOH2MELNFQTBW
X-Message-ID-Hash: G2ROKTPFIPYIOG5ZUTZJOH2MELNFQTBW
X-MailFrom: mrsohalarfanlatif16@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/G2ROKTPFIPYIOG5ZUTZJOH2MELNFQTBW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RGVhciBGcmllbmQsDQoNCkdvb2QgZGF5IHRvIHlvdSBhbmQgeW91ciBmYW1pbHkuIEkgYXBvbG9n
aXplIGlmIHRoZSBjb250ZW50IGhlcmUtdW5kZXIgYXJlDQpjb250cmFyeSB0byB5b3VyIG1vcmFs
IGV0aGljcyBidXQgcGxlYXNlIHRyZWF0IHdpdGggYWJzb2x1dGUgc2VjcmVjeSBhbmQNCnBlcnNv
bmFsLg0KDQpNeSBuYW1lIGlzIE1yLiBTb2hhbCBBcmZhbiBMYXRpZi4gZnJvbSBQYWtpc3Rhbiwg
YnV0IHdvcmtlZCBpbiBEYW1hc2N1cywNClN5cmlhLiBJIGFtIDQwIHllYXJzIE9sZC4gSSBhbSB0
aGUgU29uIHRvIGEgcGVyc29uYWwgaW52ZXN0b3IsIGFsc28gYW4gb2lsDQpUeWNvb24gZnJvbSBT
eXJpYSBhbmQgU2F1ZGkgQXJhYmlhOiBBbCBGdXJhdCBQZXRyb2xldW0gQ29tcGFueSAoQUZQQyks
IHRoZQ0KbGVhZGVyIGluIHRoZSByZWdpb24gaW4gUmVzZXJ2b2lyIE1hbmFnZW1lbnQuDQoNCkFG
UEMgd2FzIGVzdGFibGlzaGVkIHVuZGVyIFNlcnZpY2UgQ29udHJhY3Qgbm8uIDIxMCByYXRpZmll
ZCBieSBMYXcgbm8uIDQzDQpvZiAxOTc3IGFuZCBuYW1lZCBhcyBwZXIgZGVjcmVlLWxhdyBuby4g
MTIgaW4gMTk4NS4gQUZQQyBpcyBhIGpvaW50IHZlbnR1cmUNCmNvbXBhbnkgYmV0d2VlbiB0aGUg
R2VuZXJhbCBQZXRyb2xldW0gQ29ycG9yYXRpb24gKDUwJSkgYW5kIHByaXZhdGUNCnNoYXJlaG9s
ZGVycyBTeXJpYSBTaGVsbCBQZXRyb2xldW0gRGV2ZWxvcG1lbnQgKFNTUEQpIGV0Y+KApuKApuKA
pg0KDQpJIGFtIHRoZSBvbmx5IFNvbi9DaGlsZCBvZiBteSBwYXJlbnRzLiBNeSBNb3RoZXIgYW5k
IEZhdGhlciBkaWVkIGR1cmluZyB0aGUNCmVzY2FsYXRpb24gYW5kIGNsaW1heCBvZiB0aGUgU3ly
aWFuIHdhci4NCg0KQnV0IGJlZm9yZSB0aGUgd2FyIGdvdCBvdXQgb2YgaGFuZCwgbXkgRmF0aGVy
KG5vdyBsYXRlKSBtb3ZlZCBzb21lIGZ1bmRzDQppbnRvIGEgYmFuayBpbiBCdXJraW5hIEZhc28s
IFdlc3QgQWZyaWNhLCBmb3Igc2FmZXR5Lg0KDQpUaGUgYW1vdW50IHRoYXQgd2FzIG1vdmVkIHRv
IHRoZSBiYW5rIHdhcyBhIHRvdGFsIG9mICQ0Mi42TWlsbGlvbiBVU0QuIEkNCmhhZCBhcHBsaWVk
IHRvIGJvdGggYmFua3MgZm9yIHRoZSByZWxlYXNlIG9mIHRoZSBmdW5kcyB0byBtZSwgc28gdGhh
dCBJDQpjb3VsZCBzdGFydCBhIG5ldyBidXNpbmVzcywgYnV0IHRoZSBiYW5rIERpcmVjdG9ycyB0
b2xkIG1lIHRoYXQgbXkgbGF0ZQ0KRmF0aGVyIGxlZnQgYSAiTm90ZSIoV0lMTCkgaW4gdGhlIGZv
cm0gb2YgY29uZGl0aW9ucywgdGhhdCB0aGUgYmFua3MgTXVzdA0KTm90IHJlbGVhc2UgdGhlIGZ1
bmRzIHRvIG1lIHVudGlsIEkgYW0gb2YgZXhwZXJpZW5jZWQgYWdlIG9mIGludmVzdGluZyB0aGUN
CmZ1bmRzIGludG8gYSB2ZXJ5IGdvb2QgYnVzaW5lc3MgdmVudHVyZSwgYW5kIHRoZSAiV2lsbCIg
YWxzbyBzdGF0ZWQgdGhhdCBJDQpzaG91bGQgcHJlc2VudCBhbiBleHBlcmllbmNlZCBidXNpbmVz
cyBwYXJ0bmVyIGJlZm9yZSB0aGUgYmFuaywgd2hvIHdpbGwNCmFzc2lzdCBtZSBpbiBpbnZlc3Rp
bmcgd2lzZWx5LiBIYXZpbmcgc2Nob29sZWQgaW4gTG9uZG9uIGFuZCByZWFkIFBvbGl0aWNhbA0K
U2NpZW5jZSwgSSBoYXZlIG5vIGtub3dsZWRnZSBpbiBidXNpbmVzcyBpbnZlc3RtZW50IHBsYW4u
DQoNCkkgYW0gcHJlc2VudGx5IGluIGEgcmVmdWdlIGNhbXAgaW4gdGhlIFVuaXRlZCBLaW5nZG9t
Lg0KDQpUaGlzIHRoZW4gYnJvdWdodCBtZSB0byB0aGUgaXNzdWUgb2Ygc2VhcmNoaW5nIGZvciBh
IHJlcHV0YWJsZSBhbmQNCnRydXN0d29ydGh5IHBlcnNvbiwgd2hvIGhhcyB2YXN0IGV4cGVyaWVu
Y2VzIGluIHByb2ZpdGFibGUgYnVzaW5lc3NlcywNCndoZXJlIHRvIGludmVzdCB0aGUgZnVuZHMg
aW50by4NCg0KSSB3YW50IHRvIHRyYW5zZmVyIHRoaXMgZnVuZCBpbnRvIHlvdXIgYmFuayBhY2Nv
dW50IGluIHlvdXIgY291bnRyeSwgc28NCnRoYXQgd2UgY291bGQgaW52ZXN0IGl0IHdpc2VseS4g
SSBoYXZlIGNvbnRhY3RlZCB0aGUgRGlyZWN0b3Igb2YgdGhlIGJhbmsNCndoZXJlIHRoZSBmdW5k
IGlzIGRlcG9zaXRlZCBpbiBCdXJraW5hIEZhc28sIGFuZCBhc2tlZCBpZiB0aGUgZnVuZCBjb3Vs
ZCBiZQ0KbG9hZGVkIGludG8gYW4gQVRNIFZJU0EgQ0FSRCBhbmQgaGUgc2FpZCBpdCBpcyBwb3Nz
aWJsZSB0byBsb2FkIHNvbWUgb2YgdGhlDQpmdW5kcyBpbnRvIGFuIEFUTSBWSVNBIENBUkQsIHdo
aWxlIG1vc3Qgb2YgaXQgd2lsbCBiZSB3aXJlZCB0byB5b3VyIGFjY291bnQNCnZpYSBvbmxpbmUg
YmFuayB0cmFuc2Zlci4NCg0KV2h5IEkgY29udGFjdGVkIHlvdSBpcyB0aGF0IEkgd2FudCB5b3Ug
dG8gdGVsbCBtZSBtb3JlIGFib3V0IGdvb2QNCmludmVzdG1lbnRzLCBzbyB0aGF0IEkgd2lsbCBt
b3ZlIHRoaXMgZnVuZCBpbnRvIHlvdXIgYWNjb3VudCBpbiB5b3VyDQpjb3VudHJ5IHNvIHRoYXQg
SSBjb3VsZCByZWxvY2F0ZSBteSBpbnZlc3RtZW50IHBsYW4gdG8geW91ciBjb3VudHJ5Lg0KDQpU
ZWxsIG1lIG1vcmUgYWJvdXQgeW91ciBjb3VudHJ5LiBIb3cgZ29vZCBpdCB3aWxsIGJlIHRvIGlu
dmVzdCBpbiB5b3VyDQpjb3VudHJ5IENpdGllcywgU3VjaCBhcyBidXlpbmcgb2YgcHJvcGVydGll
cywgaG91c2VzLCByZWFsIGVzdGF0ZSBhbmQNCmludmVzdG1lbnRzIGluIHRvdXJpc20uDQoNCkkg
d2lsbCBhcHByZWNpYXRlIHdoYXRldmVyIHJlc3VsdCB5b3UgbWF5IGJyaWVmIG1lLiBEbyBsZXQg
bWUga25vdyB5b3VyDQppZGVhIGFuZCBrbm93bGVkZ2UgcmVnYXJkaW5nIHRoZXNlIG9yIGFueSBv
dGhlciBwcm9maXRhYmxlIGludmVzdG1lbnQgeW91DQptYXkgc3VnZ2VzdC4NCg0KVGFrZSBub3Rl
OyBBZnRlciB0aGUgd2hvbGUgZGVhbCBhbmQgdGhlIGZ1bmQgaXMgcmVsZWFzZWQgdG8gdXMsIFlv
dSB3aWxsIGJlDQpyZXdhcmRlZCB3aXRoIDIwJSBvZiB0aGUgdG90YWwgYW1vdW50IGZvciB5b3Vy
IHBhcnRpY2lwYXRpb24gYW5kIGFsc28gYmUNCnJld2FyZGVkIHdpdGggMTAlIG9mIGFueSBwcm9m
aXQgd2UgaW52ZXN0IHRoZSBtb25leSBpbnRvLg0KDQpJIHNoYWxsIHRlbGwgeW91IG1vcmUgYWJv
dXQgdGhpcyB0cmFuc2FjdGlvbiBhcyBzb29uIGFzIGkgZ2V0IHlvdXINCnJlYWRpbmVzcyBjb25j
ZXJuaW5nIHRoaXMgdHJhbnNhY3Rpb24uDQoNCldhaXRpbmcgZm9yIHlvdXIgcmVwbHksDQoNClRo
YW5rcyBhbmQgYmVzdCByZWdhcmRzLA0KTXIuIFNvaGFsIEFyZmFuIExhdGlmLg0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZkaW1tIG1haWxp
bmcgbGlzdCAtLSBsaW51eC1udmRpbW1AbGlzdHMuMDEub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gbGludXgtbnZkaW1tLWxlYXZlQGxpc3RzLjAxLm9yZwo=
